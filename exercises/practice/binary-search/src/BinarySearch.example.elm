module BinarySearch exposing (find)

import Array exposing (Array)


find : Int -> Array Int -> Maybe Int
find target xs =
    find_ 0 (Array.length xs) target xs


find_ : Int -> Int -> Int -> Array Int -> Maybe Int
find_ min max target xs =
    let
        middle =
            (min + max) // 2

        middleComp =
            Array.get middle xs
                |> Maybe.map (compare target)
    in
    if max < min then
        Nothing

    else
        case middleComp of
            Just LT ->
                find_ min (middle - 1) target xs

            Just GT ->
                find_ (middle + 1) max target xs

            Just EQ ->
                Just middle

            Nothing ->
                Nothing
