module PascalsTriangle exposing (rows)

import List


nextRow : List Int -> List Int
nextRow row =
    List.map2 (+) (0 :: row) (row ++ [ 0 ])


rows : Int -> List (List Int)
rows n =
    let
        loop i row rowsSoFar =
            if i >= n then
                List.reverse rowsSoFar

            else
                loop (i + 1) (nextRow row) (row :: rowsSoFar)
    in
    loop 0 [ 1 ] []
