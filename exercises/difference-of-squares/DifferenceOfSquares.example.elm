module DifferenceOfSquares exposing (..)


squareOfSum : Int -> Int
squareOfSum n =
    let
        sum =
            n * (n + 1) // 2
    in
    sum * sum


sumOfSquares : Int -> Int
sumOfSquares n =
    List.sum (List.map (\m -> m * m) (List.range 0 n))


difference : Int -> Int
difference n =
    squareOfSum n - sumOfSquares n
