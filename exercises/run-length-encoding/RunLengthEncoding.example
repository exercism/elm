module RunLengthEncoding exposing (version, encode, decode)

import String exposing (fromChar)
import List exposing (head, tail)
import Maybe exposing (withDefault)
import Regex


{-
   To the unaware: this was written by a very green elmer, so don't consider
   it an idiomatic exemplar to emulate.
-}


version =
    2


encode : String -> String
encode string =
    String.toList string
        |> List.foldr countChars []
        |> List.map stringifyCounts
        |> String.join ""


countChars : a -> List ( number, a ) -> List ( number, a )
countChars current counted =
    case head counted of
        Just ( count, previous ) ->
            if previous == current then
                ( count + 1, current ) :: withDefault [] (tail counted)
            else
                ( 1, current ) :: counted

        Nothing ->
            [ ( 1, current ) ]


stringifyCounts : ( number, Char ) -> String
stringifyCounts ( count, char ) =
    if count > 1 then
        toString count ++ fromChar char
    else
        fromChar char


decode : String -> String
decode string =
    string
        |> Regex.find Regex.All (Regex.regex "(\\d+)|(\\D)")
        |> List.map .match
        |> List.foldl expandCounts ( "", Nothing )
        |> fst


expandCounts : String -> ( String, Maybe Int ) -> ( String, Maybe Int )
expandCounts match ( result, count ) =
    case count of
        Just number ->
            ( result ++ String.repeat number match, Nothing )

        Nothing ->
            case String.toInt match of
                Ok number ->
                    ( result, Just number )

                Err _ ->
                    ( result ++ match, Nothing )
