module SgfParsing exposing (Tree(..), parse)

import Dict exposing (Dict)
import Parser exposing ((|.), (|=), DeadEnd, Parser, Problem(..), Step(..), Trailing(..))


type Tree
    = Node { properties : Dict String (List String), children : List Tree }


parse : String -> Result String Tree
parse =
    Parser.run (sgfWithParentheses |. Parser.end)
        >> Result.mapError
            (List.reverse >> List.head >> Maybe.map deadEndsToString >> Maybe.withDefault "")


deadEndsToString : DeadEnd -> String
deadEndsToString { problem } =
    case problem of
        ExpectingSymbol "(" ->
            "tree missing"

        ExpectingSymbol ";" ->
            "tree with no nodes"

        Expecting "[" ->
            "properties without delimiter"

        Problem string ->
            string

        _ ->
            "Unexpected error"


sgf : Parser Tree
sgf =
    Parser.oneOf [ sgfWithParentheses, sgfWithoutParentheses ]


sgfWithParentheses : Parser Tree
sgfWithParentheses =
    Parser.succeed identity
        |. Parser.symbol "("
        |= Parser.lazy (\_ -> sgfWithoutParentheses)
        |. Parser.symbol ")"


sgfWithoutParentheses : Parser Tree
sgfWithoutParentheses =
    Parser.succeed (\prop trees -> Node { properties = prop, children = trees })
        |. Parser.symbol ";"
        |= Parser.loop [] properties
        |= Parser.loop [] children


children : List Tree -> Parser (Step (List Tree) (List Tree))
children trees =
    Parser.oneOf
        [ Parser.map (\child -> Loop (child :: trees)) sgf
        , Parser.map (\_ -> Done (List.reverse trees)) (Parser.succeed ())
        ]


properties : List ( String, List String ) -> Parser (Step (List ( String, List String )) (Dict String (List String)))
properties props =
    Parser.oneOf
        [ Parser.map (\prop -> Loop (prop :: props)) property
        , Parser.map (\_ -> Done (props |> List.reverse |> Dict.fromList)) (Parser.succeed ())
        ]


property : Parser ( String, List String )
property =
    Parser.succeed Tuple.pair
        |= propertyKey
        |= Parser.sequence
            { start = "["
            , separator = "]["
            , end = "]"
            , spaces = Parser.spaces
            , item = propertyValue
            , trailing = Forbidden
            }


propertyKey : Parser String
propertyKey =
    Parser.chompIf Char.isAlpha
        |. Parser.chompWhile Char.isAlpha
        |> Parser.getChompedString
        |> Parser.andThen
            (\prop ->
                if prop == String.toUpper prop then
                    Parser.succeed prop

                else
                    Parser.problem "property must be in uppercase"
            )


propertyValue : Parser String
propertyValue =
    Parser.loop () escapedChomp
        |> Parser.getChompedString
        |> Parser.map escape


escapedChomp : () -> Parser (Step () ())
escapedChomp _ =
    Parser.oneOf
        [ Parser.chompIf (\char -> char == '\\') |. Parser.chompIf (always True) |> Parser.map (\_ -> Loop ())
        , Parser.chompIf (\char -> char /= ']') |> Parser.map (\_ -> Loop ())
        , Parser.succeed () |> Parser.map (\_ -> Done ())
        ]


escape : String -> String
escape =
    String.foldl
        (\char ( escaped, string ) ->
            case ( escaped, char ) of
                ( False, '\\' ) ->
                    ( True, string )

                ( True, 'n' ) ->
                    ( False, String.cons '\n' string )

                ( True, 't' ) ->
                    ( False, String.cons '\t' string )

                ( True, ']' ) ->
                    ( False, String.cons ']' string )

                ( True, '\\' ) ->
                    ( False, String.cons '\\' string )

                _ ->
                    ( False, String.cons char string )
        )
        ( False, "" )
        >> Tuple.second
        >> String.reverse
