module AtbashCipher exposing (decode, encode)

import Char
import Dict
import Regex exposing (HowMany(All), regex)
import String


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
    -- AKA tebahpla
    String.reverse alphabet


toTranslator : String -> String -> Char -> Char
toTranslator from to =
    let
        table =
            List.map2 (,) (String.toList from) (String.toList to)
                |> Dict.fromList

        translate key =
            Dict.get key table
                |> Maybe.withDefault key
    in
    translate


insertEvery : Int -> String -> String -> String
insertEvery size insertion string =
    Regex.replace All
        (regex (".{" ++ toString size ++ "}(?!$)"))
        (\{ match } -> match ++ insertion)
        string
