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
        , update = \_ _ -> ( (), Cmd.none )
        }



-- TYPES


type alias CanonicalData =
    { comments : List String
    , description : String
    , cases : List TestCases
    }


type TestCases
    = SingleTest TestData
    | TestGroup { comments : List String, description : String, cases : List TestCases }


type alias TestData =
    { comments : List String
    , reimplements : Maybe String
    , description : String
    , function : String
    , input : List ( String, JsonValue )
    , expected : JsonValue
    }


type alias Function =
    { arguments : List String
    , canError : Bool
    , order : Int
    }


init : Value -> ( (), Cmd () )
init value =
    case Decode.decodeValue flagDecoder value of
        Ok ( slug, data ) ->
            let
                tests =
                    writeTestFile slug data

                solution =
                    writeSolutionFile slug data
            in
            ( (), stdout (encodeFiles slug tests solution) )

        Err err ->
            let
                _ =
                    Debug.log "Unsuccessful decoding" (Debug.toString err)
            in
            ( (), Cmd.none )



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


searchFunctions : List TestCases -> Dict String Function
searchFunctions =
    let
        searchFunction : TestCases -> Dict String Function -> Dict String Function
        searchFunction testCase functions =
            case testCase of
                TestGroup { cases } ->
                    List.foldl searchFunction functions cases

                SingleTest { function, expected, input } ->
                    let
                        canError =
                            case expected of
                                JsonObject [ ( "error", _ ) ] ->
                                    True

                                _ ->
                                    False

                        currentFunction =
                            Dict.get function functions
                                |> Maybe.withDefault (Function (List.map Tuple.first input) canError (Dict.size functions))
                    in
                    Dict.insert function { currentFunction | canError = currentFunction.canError || canError } functions
    in
    List.foldl searchFunction Dict.empty


writeTestFile : String -> CanonicalData -> String
writeTestFile slug { comments, cases } =
    let
        exercise =
            kebabToPascal slug

        functions =
            searchFunctions cases
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
        |> String.replace "<tests>" (printTests slug functions cases)


{-| Prepend double dashes `--` to all comment lines extracted from the canonical data.
-}
printComments : List String -> String
printComments =
    List.map ((++) "-- ") >> String.join "\n"


{-| Generate the test code of all functions to be tested.
-}
printTests : String -> Dict String Function -> List TestCases -> String
printTests slug functions =
    List.map (printTest slug functions)
        >> String.join "\n, "


{-| Given one test case hierarchy (single test or group of subtests),
generate the code for that test case.
-}
printTest : String -> Dict String Function -> TestCases -> String
printTest slug functions testCase =
    let
        addReimplementsExplanation : Maybe String -> List String
        addReimplementsExplanation reimplements =
            case reimplements of
                Just uuid ->
                    [ "This test reimplements the test with uuid " ++ uuid
                    , "Please identify that test and remove it. Link:"
                    , "https://github.com/exercism/problem-specifications/blob/main/exercises/" ++ slug ++ "/canonical-data.json"
                    ]

                Nothing ->
                    []

        expectedValue : String -> JsonValue -> String
        expectedValue function expected =
            case ( Dict.get function functions |> Maybe.map .canError, expected ) of
                ( Just True, JsonObject [ ( "error", expectedError ) ] ) ->
                    "Err " ++ jsonValueToElmCode expectedError

                ( Just True, _ ) ->
                    "Ok " ++ jsonValueToElmCode expected

                _ ->
                    jsonValueToElmCode expected
    in
    case testCase of
        TestGroup { comments, description, cases } ->
            String.join "\n"
                [ printComments comments
                , "describe \"" ++ description ++ "\" ["
                , printTests slug functions cases
                , "]"
                ]

        SingleTest { comments, reimplements, description, function, input, expected } ->
            let
                inputArguments =
                    List.map (jsonValueToElmCode << Tuple.second) input
                        |> String.join " "
            in
            """
<comments>

-- skip <|
test "<description>" <|
  \\() ->
    <exercise>.<function> <inputs>
      |> Expect.equal (<expectedValue>)"""
                |> String.replace "<comments>" (printComments (addReimplementsExplanation reimplements ++ comments))
                |> String.replace "<description>" description
                |> String.replace "<exercise>" (kebabToPascal slug)
                |> String.replace "<function>" function
                |> String.replace "<inputs>" inputArguments
                |> String.replace "<expectedValue>" (expectedValue function expected)


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

        functionsCode =
            Dict.toList functions
                |> List.sortBy (Tuple.second >> .order)
                |> List.map printFunction
                |> String.join "\n"
    in
    """
module <exercise> exposing (<functionList>)

<functionsCode>
"""
        |> String.replace "<exercise>" exercise
        |> String.replace "<functionList>" (functions |> Dict.keys |> String.join ", ")
        |> String.replace "<functionsCode>" functionsCode


{-| Generate a template type signature and first line of the following shape,
where the function name and argument names are extraced from canonical data.

    name : todo -> Result String todo
    name arg1 =
        Debug.todo "..."

-}
printFunction : ( String, Function ) -> String
printFunction ( name, { arguments, canError } ) =
    let
        returnType =
            if canError then
                "Result String todo"

            else
                "todo"

        typeAnnotation =
            (List.repeat (List.length arguments) "todo" ++ [ returnType ])
                |> String.join " -> "
    in
    """
<name> : <typeAnnotation>
<name> <args> = Debug.todo "Please implement <name>"
"""
        |> String.replace "<name>" name
        |> String.replace "<typeAnnotation>" typeAnnotation
        |> String.replace "<args>" (String.join " " (List.map cleanVariable arguments))


makeTestPath : String -> List String
makeTestPath slug =
    [ "exercises", "practice", slug, "tests", "Tests.elm" ]


makeSolutionPath : String -> List String
makeSolutionPath slug =
    [ "exercises", "practice", slug, "src", kebabToPascal slug ++ ".elm" ]


makeExamplePath : String -> List String
makeExamplePath slug =
    [ "exercises", "practice", slug, ".meta", "src", kebabToPascal slug ++ ".example.elm" ]



-- DECODERS


{-| Convert a JSON value to Elm code as close as possible.
-}
jsonValueToElmCode : JsonValue -> String
jsonValueToElmCode json =
    case json of
        Null ->
            "Null"

        JsonBool True ->
            "True"

        JsonBool False ->
            "False"

        JsonInt integer ->
            String.fromInt integer

        JsonFloat float ->
            String.fromFloat float

        JsonString str ->
            Encode.encode 0 (Encode.string str)

        JsonList list ->
            List.map jsonValueToElmCode list
                |> (\encodedList -> "[ " ++ String.join ", " encodedList ++ " ]")

        JsonObject obj ->
            List.map (\( key, val ) -> cleanVariable key ++ " = " ++ jsonValueToElmCode val) obj
                |> (\encodedList -> "{ " ++ String.join ", " encodedList ++ " }")


{-| Generic type describing the different shapes a JSON value can take.
-}
type JsonValue
    = Null
    | JsonBool Bool
    | JsonInt Int
    | JsonFloat Float
    | JsonString String
    | JsonList (List JsonValue)
    | JsonObject (List ( String, JsonValue ))


{-| Decoder for a generic JSON value
-}
jsonValueDecoder : Decoder JsonValue
jsonValueDecoder =
    Decode.oneOf
        [ Decode.null Null
        , Decode.map JsonBool Decode.bool
        , Decode.map JsonInt Decode.int
        , Decode.map JsonFloat Decode.float
        , Decode.map JsonString Decode.string
        , Decode.map JsonList (Decode.list (Decode.lazy (\_ -> jsonValueDecoder)))
        , Decode.map JsonObject (Decode.keyValuePairs (Decode.lazy (\_ -> jsonValueDecoder)))
        ]


flagDecoder : Decoder ( String, CanonicalData )
flagDecoder =
    Decode.map2 Tuple.pair
        (Decode.field "slug" Decode.string)
        (Decode.field "data" canonicalDataDecoder)


{-| Uncapitalize and replace reserved words.

Input variables are printed in the stub file. If some of them coincide with Elm reserved words, they must be replaced or the file won't compile or get formatted.

-}
cleanVariable : String -> String
cleanVariable string =
    let
        word =
            case String.uncons string of
                Nothing ->
                    ""

                Just ( head, tail ) ->
                    String.cons (Char.toLower head) tail

        words =
            Set.fromList [ "if", "then", "else", "case", "of", "let", "in", "type", "module", "where", "import", "exposing", "as", "port" ]
    in
    if Set.member word words then
        word ++ "Value"

    else
        word


commentsDecoder : Decoder (List String)
commentsDecoder =
    Decode.oneOf
        [ Decode.string
            |> Decode.list
            |> Decode.field "comments"
        , Decode.succeed []
        ]


canonicalDataDecoder : Decoder CanonicalData
canonicalDataDecoder =
    Decode.map3 CanonicalData
        commentsDecoder
        (Decode.field "exercise" Decode.string)
        (Decode.field "cases" (Decode.list caseDecoder))


caseDecoder : Decoder TestCases
caseDecoder =
    Decode.oneOf
        [ Decode.map SingleTest testDecoder
        , Decode.map3 CanonicalData
            commentsDecoder
            (Decode.field "description" Decode.string)
            (Decode.field "cases" (Decode.list (Decode.lazy (\() -> caseDecoder))))
            |> Decode.map TestGroup
        ]


testDecoder : Decoder TestData
testDecoder =
    Decode.map6 TestData
        commentsDecoder
        (Decode.maybe (Decode.field "reimplements" Decode.string))
        (Decode.field "description" Decode.string)
        (Decode.field "property" Decode.string)
        (Decode.field "input" (Decode.keyValuePairs jsonValueDecoder))
        (Decode.field "expected" jsonValueDecoder)


encodeFiles : String -> String -> String -> Value
encodeFiles slug testFile solutionFile =
    Encode.list identity
        [ encodeFile (makeTestPath slug) testFile
        , encodeFile (makeSolutionPath slug) solutionFile
        , encodeFile (makeExamplePath slug) solutionFile
        ]


encodeFile : List String -> String -> Value
encodeFile path file =
    Encode.object [ ( "path", Encode.list Encode.string path ), ( "file", Encode.string file ) ]
