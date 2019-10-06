module ArmstrongNumbers exposing (check)


check : Int -> Bool
check nb =
    let
        ( digits, nbDigits ) =
            digitsAndLength nb
    in
    nb == List.sum (List.map (\a -> a ^ nbDigits) digits)


digitsAndLength : Int -> ( List Int, Int )
digitsAndLength nb =
    if nb < 10 then
        ( [ nb ], 1 )

    else
        let
            ( digits, n ) =
                digitsAndLength (nb // 10)
        in
        ( modBy 10 nb :: digits, 1 + n )
