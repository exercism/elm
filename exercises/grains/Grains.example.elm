module Grains exposing (square, total)


square : Int -> Maybe Int
square n =
    if n < 1 then
        Nothing

    else
        Just <| 2 ^ (n - 1)


total : Int -> Maybe Int
total n =
    if n < 1 then
        Nothing

    else
        Just <| 2 ^ n - 1
