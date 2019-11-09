module RunLengthEncoding exposing (decode, encode)

import List exposing (head, tail)
import Maybe exposing (withDefault)
import Regex exposing (Regex)
import String exposing (fromChar)



{-
   To the unaware: this was written by a very green elmer, so don't consider
   it an idiomatic exemplar to emulate.
-}


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


stringifyCounts : ( Int, Char ) -> String
stringifyCounts ( count, char ) =
    if count > 1 then
        String.fromInt count ++ fromChar char

    else
        fromChar char


decode : String -> String
decode string =
    string
        |> Regex.find (regex "(\\d+)|(\\D)")
        |> List.map .match
        |> List.foldl expandCounts ( "", Nothing )
        |> Tuple.first


expandCounts : String -> ( String, Maybe Int ) -> ( String, Maybe Int )
expandCounts match ( result, count ) =
    case count of
        Just number ->
            ( result ++ String.repeat number match, Nothing )

        Nothing ->
            case String.toInt match of
                Just number ->
                    ( result, Just number )

                Nothing ->
                    ( result ++ match, Nothing )


regex : String -> Regex
regex string =
    string
        |> Regex.fromString
        |> Maybe.withDefault Regex.never
