module RotationalCipher exposing (rotate)

import Char


rotate : String -> Int -> String
rotate text shiftKey =
    text
        |> String.toList
        |> List.map (shiftChar shiftKey)
        |> String.fromList


shiftChar : Int -> Char -> Char
shiftChar shiftKey char =
    let
        shift refCode =
            (Char.toCode char - refCode)
                |> (+) shiftKey
                |> modBy 26
                |> (+) refCode
                |> Char.fromCode
    in
    if 'a' <= char && char <= 'z' then
        shift (Char.toCode 'a')

    else if 'A' <= char && char <= 'Z' then
        shift (Char.toCode 'A')

    else
        char
