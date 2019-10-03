module PythagoreanTriplets exposing (triplets)

import List


type alias Triplet =
    ( Int, Int, Int )


triplets : Int -> List Triplet
triplets n =
    List.range 1 (n - 2)
        |> List.concatMap
            (\a ->
                List.range a (n - 1)
                    |> List.filterMap
                        (\b ->
                            let
                                c =
                                    n - a - b
                            in
                            if a * a + b * b == c * c then
                                Just ( a, b, c )

                            else
                                Nothing
                        )
            )
