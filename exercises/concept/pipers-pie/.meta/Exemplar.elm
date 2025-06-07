module PipersPie exposing (doubleFactorial, factorial, pipersPi)


factorial : Int -> Int
factorial n =
    factorialHelper n 1


factorialHelper : Int -> Int -> Int
factorialHelper n resultSoFar =
    if n <= 1 then
        resultSoFar

    else
        factorialHelper (n - 1) (n * resultSoFar)


doubleFactorial : Int -> Int
doubleFactorial n =
    doubleFactorialHelper n 1


doubleFactorialHelper : Int -> Int -> Int
doubleFactorialHelper n resultSoFar =
    if n <= 1 then
        resultSoFar

    else
        doubleFactorialHelper (n - 2) (n * resultSoFar)


pipersPi : Int -> Float
pipersPi limit =
    pipersPiHelper limit 1 2.0 2.0


pipersPiHelper : Int -> Int -> Float -> Float -> Float
pipersPiHelper limit n resultSoFar oldTerm =
    if limit <= 0 then
        resultSoFar

    else
        let
            term =
                oldTerm / (2 + 1 / toFloat n)
        in
        pipersPiHelper (limit - 1) (n + 1) (resultSoFar + term) term
