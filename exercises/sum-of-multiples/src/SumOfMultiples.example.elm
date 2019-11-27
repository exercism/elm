module SumOfMultiples exposing (sumOfMultiples)


sumOfMultiples : List Int -> Int -> Int
sumOfMultiples divisors limit =
    List.sum (List.filter (inMultiples divisors) (List.range 1 (limit - 1)))


inMultiples : List Int -> Int -> Bool
inMultiples divisors candidate =
    List.any (\divisor -> modBy divisor candidate == 0) divisors
