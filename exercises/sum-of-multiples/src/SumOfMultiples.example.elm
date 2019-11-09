module SumOfMultiples exposing (sumOfMultiples)


sumOfMultiples : List Int -> Int -> Int
sumOfMultiples multiples limit =
    List.sum (List.filter (inMultiples multiples) (List.range 1 (limit - 1)))


inMultiples : List Int -> Int -> Bool
inMultiples multiples candidate =
    List.any (\factor -> modBy factor candidate == 0) multiples
