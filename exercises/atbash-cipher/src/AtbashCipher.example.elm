module AtbashCipher exposing (decode, encode)

import Char
import Dict
import Regex exposing (Regex)
import String
import Tuple


encode : String -> String
encode plain =
    let
        translate =
            toTranslator alphabet reversedAlphabet
    in
    plain
        |> String.toLower
        |> String.filter (\c -> Char.isLower c || Char.isDigit c)
        |> String.map translate
        |> insertEvery 5 " "


decode : String -> String
decode cipher =
    let
        translate =
            toTranslator reversedAlphabet alphabet
    in
    cipher
        |> String.filter ((/=) ' ')
        |> String.map translate


alphabet : String
alphabet =
    "abcdefghijklmnopqrstuvwxyz"


reversedAlphabet : String
reversedAlphabet =
    String.reverse alphabet


toTranslator : String -> String -> Char -> Char
toTranslator from to =
    let
        table =
            List.map2 Tuple.pair (String.toList from) (String.toList to)
                |> Dict.fromList

        translate key =
            Dict.get key table
                |> Maybe.withDefault key
    in
    translate


insertEvery : Int -> String -> String -> String
insertEvery size insertion string =
    let
        sizeRegex =
            ".{" ++ String.fromInt size ++ "}(?!$)"
    in
    case Regex.fromString sizeRegex of
        Nothing ->
            string

        Just regex ->
            Regex.replace regex (\{ match } -> match ++ insertion) string
