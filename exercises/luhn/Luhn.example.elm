module Luhn exposing (valid)

import Char exposing (isDigit)
import Regex exposing (regex)
import String


valid : String -> Bool
valid input =
    let
        nonDigit =
            Regex.contains (regex "[^0-9 ]") input

        tooShort =
            String.length digits < 2

        digits =
            String.filter isDigit input
    in
    if nonDigit || tooShort then
        False

    else
        checksum digits == 0


checksum : String -> Int
checksum input =
    let
        calculate x =
            if x < 5 then
                x * 2

            else
                x * 2 - 9

        remainder x =
            x % 10
    in
    input
        |> String.reverse
        |> String.toList
        |> List.map (Result.withDefault 0 << String.toInt << String.fromChar)
        |> List.indexedMap (,)
        |> List.map
            (\( i, x ) ->
                if i % 2 == 0 then
                    x

                else
                    calculate x
            )
        |> List.sum
        |> remainder
