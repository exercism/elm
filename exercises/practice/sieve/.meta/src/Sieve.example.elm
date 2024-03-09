module Sieve exposing (primes)

import Array exposing (Array)


primes : Int -> List Int
primes limit =
    let
        -- an array, with indices from 0 until limit, each with a Bool value representing primeness
        initialSieve =
            Array.initialize (limit + 1) (\n -> n >= 2)

        initialPrime =
            Just 2
    in
    runSieve initialPrime initialSieve
        |> Array.toIndexedList
        |> List.filterMap
            (\( index, isPrime ) ->
                if isPrime then
                    Just index

                else
                    Nothing
            )


runSieve : Maybe Int -> Array Bool -> Array Bool
runSieve maybePrime sieve =
    case maybePrime of
        Nothing ->
            sieve

        Just prime ->
            let
                removeMultiples : Int -> Array Bool -> Array Bool
                removeMultiples multiple =
                    if multiple > Array.length sieve then
                        identity

                    else
                        Array.set multiple False
                            >> removeMultiples (multiple + prime)

                sieveWithPrimeMultipleRemoved : Array Bool
                sieveWithPrimeMultipleRemoved =
                    removeMultiples (2 * prime) sieve

                findNextPrime : Int -> Maybe Int
                findNextPrime index =
                    case Array.get index sieveWithPrimeMultipleRemoved of
                        Nothing ->
                            Nothing

                        Just True ->
                            Just index

                        Just False ->
                            findNextPrime (index + 1)
            in
            runSieve (findNextPrime (prime + 1)) sieveWithPrimeMultipleRemoved
