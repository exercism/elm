module Darts exposing (score)


score : Float -> Float -> Int
score x y =
    let
        distance =
            x * x + y * y
    in
    if distance > 100 then
        0

    else if distance > 25 then
        1

    else if distance > 1 then
        5

    else
        10
