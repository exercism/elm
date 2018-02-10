module BinarySearch exposing (find)

import Array exposing (Array)


find : Int -> Array Int -> Int
find target xs =
    find_ 0 (Array.length xs) target xs


find_ : Int -> Int -> Int -> Array Int -> Int
find_ i0 i1 target xs =
    let
        i =
            (i1 + i0) // 2

        isEqual =
            Array.get i xs
                |> (==) (Just target)

        isLessThan =
            Array.get i xs
                |> Maybe.map ((<) target)
    in
    case ( isEqual, isLessThan, i0 > i1 ) of
        ( True, _, _ ) ->
            i

        ( False, Just True, False ) ->
            find_ i0 (i - 1) target xs

        ( False, Just False, False ) ->
            find_ (i + 1) i1 target xs

        _ ->
            -1
