port module Main exposing (main)

import Dict exposing (Dict)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import Set


port stdout : Value -> Cmd msg


main : Program Value () ()
main =
    Platform.worker
        { init = init
        , subscriptions = \_ -> Sub.none
        , update = \_ _ -> ((), Cmd.none)
        }



-- TYPES




type alias CanonicalData =
    { comments : Maybe (List String)
    , description : String
    , cases : List Case
    }


type Case
    = Leaf Test
    | Nested CanonicalData


type alias Test =
    { comments : Maybe (List String)
    , reimplements : Maybe String
    , description : String
    , function : String
    , input : List ( String, String )
    , expected : String
    }


type Function
    = Direct
    | Result


init : Value-> ( (), Cmd () )
init value =
  case Decode.decodeValue flagDecoder value of
    Ok (slug, data) ->
        let
            tests =
                                        writeTestFile slug data 
            solution =
                                    writeSolutionFile slug data
        in 
            ( (), stdout (encodeFiles slug tests solution) )
    Err err -> let
                        _ =
                            Debug.log "Unsuccessful decoding" (Debug.toString err)
                in
                    ((), Cmd.none)




-- WRITING FILES


kebabToPascal : String -> String
kebabToPascal =
    let
        capitalize : String -> String
        capitalize string =
            case String.uncons string of
                Nothing ->
                    ""

                Just ( head, tail ) ->
                    String.cons (Char.toUpper head) tail
    in
    String.split "-" >> List.map capitalize >> String.concat


searchFunctions : List Case -> Dict String ( Function, List String )
searchFunctions =
    let
        searchFunction : Case -> Dict String ( Function, List String ) -> Dict String ( Function, List String )
        searchFunction testCase functions =
            case testCase of
                Nested { cases } ->
                    List.foldl searchFunction functions cases

                Leaf { function, expected, input } ->
                    let
                        args =
                            List.map Tuple.first input
                    in
                    if String.contains "{error=" expected then
                        Dict.insert function ( Result, args ) functions

                    else
                        Dict.update function (Maybe.withDefault ( Direct, args ) >> Just) functions
    in
    List.foldl searchFunction Dict.empty


writeTestFile : String -> CanonicalData -> String
writeTestFile slug { comments, cases } =
    let
        exercise =
            kebabToPascal slug

        functions =
            searchFunctions cases

        removeFirstSkip file =
            case String.indices "skip <|" file of
                first :: _ ->
                    String.left first file ++ String.dropLeft (first + String.length "skip <|") file

                _ ->
                    file
    in
    """
module Tests exposing (tests)

import <exercise>
import Expect
import Test exposing (Test, describe, skip, test)

<comments>
tests : Test
tests = describe "<exercise>" [
<tests>
]
"""
        |> String.replace "<exercise>" exercise
        |> String.replace "<comments>" (printComments comments)
        |> String.replace "<tests>" (printTests exercise functions cases)
        |> removeFirstSkip


{-| Prepend double dashes `--` to all comment lines extracted from the canonical data.

-- PS: no need for both the `Maybe` and the `List`.
-- The List is sufficient.

-}
printComments : Maybe (List String) -> String
printComments maybeComments =
    case maybeComments of
        Nothing ->
            ""

        Just comments ->
            comments
                |> List.map ((++) "-- ")
                |> String.join "\n"


{-| Generate the test code of all functions to be tested.
-}
printTests : String -> Dict String ( Function, List String ) -> List Case -> String
printTests exercise functions =
    List.map (printTest exercise functions)
        >> String.join "\n, "


{-| Given one test case hierarchy (single test or group of subtests),
generate the code for that test case.
-}
printTest : String -> Dict String ( Function, List String ) -> Case -> String
printTest exercise functions testCase =
    let
        addReimplementsExplanation : Maybe String -> Maybe String
        addReimplementsExplanation =
            Maybe.map
                (\uuid ->
                    "This exercises reimplements another exercise with uuid "
                        ++ uuid
                        ++ "\n-- Please identify that exercise and remove it."
                )

        expectedValue : String -> String -> String
        expectedValue function expected =
            case ( Dict.get function functions, String.contains "{error=" expected ) of
                ( Just ( Result, _ ), True ) ->
                    "Err " ++ String.slice 7 -1 expected

                ( Just ( Result, _ ), False ) ->
                    "Ok " ++ expected

                _ ->
                    expected
    in
    case testCase of
        Nested { comments, description, cases } ->
            [ printComments comments
            , "describe \"" ++ description ++ "\" ["
            , printTests exercise functions cases
            , "]"
            ]
                |> String.join "\n"

        Leaf { comments, reimplements, description, function, input, expected } ->
            -- Maybe.map2 here isn't what you'd expect because if one of the two is missing,
            -- then nothing is printed instead of printing the one provided.
            [ printComments (Maybe.map2 (::) (addReimplementsExplanation reimplements) comments)
            , "skip <|"
            , "test \"" ++ description ++ "\" <|"
            , "\\() ->"
            , exercise ++ "." ++ function ++ " " ++ (input |> List.map Tuple.second |> String.join " ")
            , "|> Expect.equal (" ++ expectedValue function expected ++ ")"
            ]
                |> String.join "\n"


{-| Generate the template for the solution file.

The list of public functions is exposed, and for each one,
a template type signature and first line is generated.

-}
writeSolutionFile : String -> CanonicalData -> String
writeSolutionFile slug { cases } =
    let
        exercise =
            kebabToPascal slug

        functions =
            searchFunctions cases
    in
    """
module <exercise> exposing (<functionList>)

<functions>
"""
        |> String.replace "<exercise>" exercise
        |> String.replace "<functionList>" (functions |> Dict.keys |> String.join ", ")
        |> String.replace "<functions>" (functions |> Dict.toList |> List.map printFunction |> String.join "\n")


{-| Generate a template type signature and first line of the following shape,
where the function name and argument names are extraced from canonical data.

    name : todo -> Result String todo
    name arg1 =
        Debug.todo "..."

-}
printFunction : ( String, ( Function, List String ) ) -> String
printFunction ( name, ( functionType, args ) ) =
    let
        finalType =
            case functionType of
                Direct ->
                    "todo"

                Result ->
                    "Result String todo"
    in
    [ name ++ " : " ++ String.join " -> " (List.map (always "todo") args) ++ " -> " ++ finalType
    , String.join " " (name :: args) ++ " = Debug.todo \"Please implement " ++ name ++ "\""
    ]
        |> String.join "\n"


makeTestPath : String -> String
makeTestPath slug =
    [ "exercises", "practice", slug, "tests", "Tests.elm" ]
        |> String.join "/"


makeSolutionPath : String -> String
makeSolutionPath slug =
    [ "exercises", "practice", slug, "src", kebabToPascal slug ++ ".elm" ]
        |> String.join "/"


makeExamplePath : String -> String
makeExamplePath slug =
    [ "exercises", "practice", slug, ".meta", "src", kebabToPascal slug ++ ".example.elm" ]
        |> String.join "/"



-- DECODERS, REQUESTS

flagDecoder : Decoder (String, CanonicalData)
flagDecoder = 
  Decode.map2 Tuple.pair
        (Decode.field "slug" Decode.string)
        (Decode.field "data" canonicalDataDecoder)
    

valueDecoder : Decoder String
valueDecoder =
    Decode.oneOf
        [ Decode.string |> Decode.map (\string -> "\"" ++ string ++ "\"")
        , Decode.int |> Decode.map String.fromInt
        , Decode.float |> Decode.map String.fromFloat
        , Decode.bool
            |> Decode.map
                (\b ->
                    if b then
                        "True"

                    else
                        "False"
                )
        , Decode.null "Nothing"
        , Decode.list (Decode.lazy (\() -> valueDecoder)) |> Decode.map (\v -> "[" ++ String.join "," v ++ "]")
        , Decode.keyValuePairs (Decode.lazy (\() -> valueDecoder))
            |> Decode.map
                (\kv -> "{" ++ String.join "," (List.map (\( k, v ) -> replaceReservedWord k ++ "=" ++ v) kv) ++ "}")
        ]


{-| tod
-}
replaceReservedWord : String -> String
replaceReservedWord word =
    let
        words =
            Set.fromList [ "if", "then", "else", "case", "of", "let", "in", "type", "module", "where", "import", "exposing", "as", "port" ]
    in
    if Set.member word words then
        word ++ "Value"

    else
        word


commentsDecoder : Decoder (Maybe (List String))
commentsDecoder =
    Decode.string
        |> Decode.list
        |> Decode.field "comments"
        |> Decode.maybe


canonicalDataDecoder : Decoder CanonicalData
canonicalDataDecoder =
    Decode.map3 CanonicalData
        commentsDecoder
        (Decode.field "exercise" Decode.string)
        (Decode.field "cases" (Decode.list caseDecoder))


caseDecoder : Decoder Case
caseDecoder =
    Decode.oneOf
        [ Decode.map Leaf testDecoder
        , Decode.map3 CanonicalData
            commentsDecoder
            (Decode.field "description" Decode.string)
            (Decode.field "cases" (Decode.list (Decode.lazy (\() -> caseDecoder))))
            |> Decode.map Nested
        ]


testDecoder : Decoder Test
testDecoder =
    Decode.map6 Test
        commentsDecoder
        (Decode.maybe (Decode.field "reimplements" Decode.string))
        (Decode.field "description" Decode.string)
        (Decode.field "property" Decode.string)
        (Decode.field "input" (Decode.keyValuePairs valueDecoder))
        (Decode.field "expected" valueDecoder)




encodeFiles : String -> String -> String -> Value
encodeFiles slug testFile solutionFile =
    Encode.list identity
        [ encodeFile (makeTestPath slug) testFile
        , encodeFile (makeSolutionPath slug) solutionFile
        , encodeFile (makeExamplePath slug) solutionFile
        ]


encodeFile : String -> String -> Value
encodeFile path file =
    Encode.object [ ( "path", Encode.string path ), ( "file", Encode.string file ) ]