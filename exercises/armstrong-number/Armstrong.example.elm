module Armstrong exposing (isArmstrongNumber)

import List


isArmstrongNumber : Int -> Bool
isArmstrongNumber n =
    numberToDigits n []
        |> (\digits ->
                List.map (\d -> d ^ List.length digits) digits
           )
        |> List.sum
        |> (==) n


numberToDigits : Int -> List Int -> List Int
numberToDigits n list =
    if n // 10 == 0 then
        n :: list

    else
        numberToDigits (n // 10) <| remainderBy 10 n :: list
