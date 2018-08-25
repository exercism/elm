module Acronym exposing (abbreviate)

import Regex exposing (Regex)
import String


abbreviate : String -> String
abbreviate phrase =
    phrase
        |> Regex.split dashOrSpace
        |> List.map firstLetter
        |> String.join ""


firstLetter : String -> String
firstLetter word =
    case String.uncons word of
        Just ( letter, _ ) ->
            String.toUpper <| String.fromChar letter

        Nothing ->
            ""


dashOrSpace : Regex
dashOrSpace =
    Maybe.withDefault Regex.never <|
        Regex.fromString "[ -]"
