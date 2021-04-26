module PythagoreanTriplet exposing (triplets)

-- Solution inspired by cmcaine's answer in the Julia track.
-- https://github.com/exercism/julia/blob/c6b067b39fb5217c745fba23906248a19521c7be/exercises/practice/pythagorean-triplet/.meta/example.jl


type alias Triplet =
    ( Int, Int, Int )


{-| For an integer n, find all triplets a,b,c such that:
a < b < c
a + b + c = n
a^2 + b^2 = c^2
-}
triplets : Int -> List Triplet
triplets n =
    -- 3 is the range start since 3,4,5 is the lowest Pythagorean triplet.
    -- n // 3 is the range end since we have a < b < c and a + b + c = n.
    List.range 3 (n // 3)
        |> List.filterMap (computeTriplet n)


{-| Given n and a, find the value for b and c that complete the a,b,c triplet.
-}
computeTriplet : Int -> Int -> Maybe Triplet
computeTriplet n a =
    -- From the equations:
    --    a + b + c = n        (1)
    --    a^2 + b^2 = c^2      (2)
    -- we can replace c by (n - a - b) and inject it in (2) to find that
    --    b = n(n-2a) / 2(n-a)
    -- which is only valid if b > a and b is an integer.
    let
        num =
            n * (n - 2 * a)

        denum =
            2 * (n - a)

        b =
            num // denum
    in
    if b > a && b * denum == num then
        Just ( a, b, n - a - b )

    else
        Nothing
