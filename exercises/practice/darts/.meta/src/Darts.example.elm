module Darts exposing (score)


score : Float -> Float -> Int
score x y =
    let
        distance =
            sqrt (x * x + y * y)
    in
    if distance > 10 then
        0

    else if distance > 5 then
        1

    else if distance > 1 then
        5

    else
        10
