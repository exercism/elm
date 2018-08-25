module LargestSeriesProduct exposing (largestProduct)

import String


largestProduct : Int -> String -> Maybe Int
largestProduct length series =
    if length < 0 then
        Nothing

    else if length == 0 then
        Just 1

    else
        String.split "" series
            |> List.map String.toInt
            |> combineResults
            |> Result.toMaybe
            |> Maybe.map
                (takeRuns length
                    >> List.map List.product
                    >> List.maximum
                )
            |> joinMaybe


takeRuns : Int -> List a -> List (List a)
takeRuns size items =
    let
        candidate =
            List.take size items
    in
    if List.length candidate < size || size < 1 then
        []

    else
        candidate :: takeRuns size (List.drop 1 items)



-- inlined from Results.Extra and Maybe.Extra


combineResults : List (Result x a) -> Result x (List a)
combineResults =
    List.foldr (Result.map2 (::)) (Ok [])


joinMaybe : Maybe (Maybe a) -> Maybe a
joinMaybe mx =
    case mx of
        Just x ->
            x

        Nothing ->
            Nothing
