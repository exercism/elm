module ScrabbleScore exposing (..)

import String exposing (contains, foldl, fromChar, toUpper)


addLetterScore : Char -> Int -> Int
addLetterScore s total =
    let
        c =
            toUpper (fromChar s)
    in
        if contains c "AEIOULNRST" then
            total + 1
        else if contains c "DG" then
            total + 2
        else if contains c "BCMP" then
            total + 3
        else if contains c "FHVWY" then
            total + 4
        else if contains c "K" then
            total + 5
        else if contains c "JX" then
            total + 8
        else if contains c "QZ" then
            total + 10
        else
            total


scoreWord : String -> Int
scoreWord x =
    x |> foldl addLetterScore 0
