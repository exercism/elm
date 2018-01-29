module Hamming exposing (..)

import String exposing (length, toList)


distance : String -> String -> Result String Int
distance left right =
    if length left /= length right then
        Err "left and right strands must be of equal length"
    else
        List.map2 (\l r -> l /= r) (toList left) (toList right)
            |> List.filter identity
            |> List.length
            |> Ok
