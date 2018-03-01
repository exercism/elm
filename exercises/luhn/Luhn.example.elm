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
            String.length (String.trim input) < 2
    in
        if nonDigit || tooShort then
            False
        else
            luhn (stripToList input) == 0


luhn : List ( Int, Int ) -> Int
luhn list =
    let
        subtract x =
            if x > 9 then
                x - 9
            else
                x

        double =
            (*) 2

        remainder x =
            x % 10
    in
        list
            |> List.map
                (\( i, x ) ->
                    if i % 2 == 0 then
                        x
                    else
                        (subtract << double) x
                )
            |> List.sum
            |> remainder


stripToList : String -> List ( Int, Int )
stripToList input =
    let
        toInt =
            Result.withDefault 0 << String.toInt << String.fromChar
    in
        input
            |> String.filter isDigit
            |> String.reverse
            |> String.toList
            |> List.map toInt
            |> List.indexedMap (,)
