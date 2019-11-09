module RomanNumerals exposing (toRoman)

import Dict
import Maybe


toRoman : Int -> String
toRoman number =
    if number == 0 then
        ""

    else
        let
            part =
                largestFactor number

            letter =
                numerals
                    |> Dict.get part
                    |> Maybe.withDefault ""
        in
        letter ++ toRoman (number - part)


largestFactor : Int -> Int
largestFactor number =
    numerals
        |> Dict.keys
        |> List.filter (\p -> p <= number)
        |> List.reverse
        |> List.head
        |> Maybe.withDefault 0


numerals : Dict.Dict Int String
numerals =
    Dict.fromList
        [ ( 1000, "M" )
        , ( 900, "CM" )
        , ( 500, "D" )
        , ( 400, "CD" )
        , ( 100, "C" )
        , ( 90, "XC" )
        , ( 50, "L" )
        , ( 40, "XL" )
        , ( 10, "X" )
        , ( 9, "IX" )
        , ( 5, "V" )
        , ( 4, "IV" )
        , ( 1, "I" )
        ]
