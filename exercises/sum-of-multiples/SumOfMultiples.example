module SumOfMultiplesExample where

sumOfMultiples : List Int -> Int -> Int
sumOfMultiples factors upperLimit =
  List.sum (List.filter (isMultipleOfAnyFactor factors) [1 .. (upperLimit - 1)])

isMultipleOfAnyFactor : List Int -> Int -> Bool
isMultipleOfAnyFactor factors candidate =
  List.any (\factor ->  candidate % factor == 0) factors
