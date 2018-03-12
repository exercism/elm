module Acronym exposing (abbreviate)

import Regex exposing (HowMany(All), regex)
import String


abbreviate : String -> String
abbreviate phrase =
    phrase
        |> Regex.split All (regex "[ -]")
        |> List.map firstLetter
        |> String.join ""


firstLetter : String -> String
firstLetter word =
    case String.uncons word of
        Just ( letter, _ ) ->
            String.toUpper <| String.fromChar letter

        Nothing ->
            ""
