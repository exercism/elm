module AllYourBase exposing (..)

import List


fromBase : Int -> List Int -> Maybe Int
fromBase base =
    let
        f x m =
            case m of
                Nothing ->
                    Nothing

                Just n ->
                    if x >= 0 && x < base then
                        Just (n * base + x)
                    else
                        Nothing
    in
    List.foldl f (Just 0)


toBase : Int -> Int -> List Int
toBase base =
    let
        divMod a b =
            ( a // b, a % b )

        swap ( a, b ) =
            ( b, a )

        unfold f b =
            case f b of
                Just ( a, b_ ) ->
                    a :: unfold f b_

                Nothing ->
                    []

        f x =
            case x of
                0 ->
                    Nothing

                _ ->
                    Just (swap (divMod x base))
    in
    List.reverse << unfold f


rebase : Int -> List Int -> Int -> Maybe (List Int)
rebase inBase digits outBase =
    let
        length =
            List.length digits

        numZeros =
            List.length (List.filter (\x -> x == 0) digits)
    in
    if inBase < 2 || outBase < 2 || length == 0 || length == numZeros then
        Nothing
    else
        case fromBase inBase digits of
            Just v ->
                Just (toBase outBase v)

            Nothing ->
                Nothing
