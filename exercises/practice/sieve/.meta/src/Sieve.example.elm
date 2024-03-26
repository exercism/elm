module Sieve exposing (primes)

import Array exposing (Array)


primes : Int -> List Int
primes limit =
    makeCandidates limit
        |> markMultiples limit
        |> extractPrimes


makeCandidates : Int -> Array Bool
makeCandidates limit =
    Array.repeat (limit + 1) True
        |> Array.set 0 False
        |> Array.set 1 False


extractPrimes : Array Bool -> List Int
extractPrimes candidates =
    Array.indexedMap (\idx val -> ( idx, val )) candidates
        |> Array.filter (\( _, isPrime ) -> isPrime)
        |> Array.map Tuple.first
        |> Array.toList


markMultiples : Int -> Array Bool -> Array Bool
markMultiples limit candidates =
    mark limit 2 candidates


mark limit candidate candidates =
    if candidate > isqrt limit then
        candidates

    else
        case Array.get candidate candidates of
            Nothing ->
                -- should not happen
                Array.empty

            Just True ->
                mark
                    limit
                    (candidate + 1)
                    (markMultiplesOfPrime
                        limit
                        candidate
                        (candidate * candidate)
                        candidates
                    )

            Just False ->
                mark
                    limit
                    (candidate + 1)
                    candidates


markMultiplesOfPrime limit prime current candidates =
    if current > limit then
        candidates

    else
        markMultiplesOfPrime
            limit
            prime
            (current + prime)
            (Array.set current False candidates)


isqrt : Int -> Int
isqrt =
    toFloat >> sqrt >> floor
