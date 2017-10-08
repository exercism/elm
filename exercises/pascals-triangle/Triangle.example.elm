module Triangle exposing (rows)

import List


nextRow : List Int -> List Int
nextRow row =
    List.map2 (+) (0 :: row) (row ++ [ 0 ])


rows : Int -> List (List Int)
rows n =
    let
        loop i row =
            if i == n then
                []
            else
                row :: loop (i + 1) (nextRow row)
    in
        if n < 0 then
            []
        else
            loop 0 [ 1 ]
