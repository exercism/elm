module Series exposing (slices)

import List
import Result
import String


slices : Int -> String -> Result String (List (List Int))
slices size input =
    if size < 0 then
        Err "slice length cannot be negative"

    else if size == 0 then
        Err "slice length cannot be zero"

    else if String.isEmpty input then
        Err "series cannot be empty"

    else if String.length input < size then
        Err "slice length cannot be greater than series length"

    else
        String.split "" input
            |> List.map String.toInt
            |> combine
            |> Maybe.map (takeRuns size)
            |> Result.fromMaybe ""


takeRuns : Int -> List Int -> List (List Int)
takeRuns size numbers =
    let
        candidate =
            List.take size numbers
    in
    if List.length candidate < size || size < 1 then
        []

    else
        candidate :: takeRuns size (List.drop 1 numbers)


combine : List (Maybe a) -> Maybe (List a)
combine =
    List.foldr (Maybe.map2 (::)) (Just [])
