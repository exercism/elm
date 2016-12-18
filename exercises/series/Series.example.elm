module Series exposing (..)

import String
import List
import Result


slices : Int -> String -> Result String (List (List Int))
slices size input =
    if size < 1 then
        Err ("Invalid size: " ++ toString size)
    else
        String.split "" input
            |> List.map String.toInt
            |> combine
            |> Result.map (takeRuns size)


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


combine : List (Result x a) -> Result x (List a)
combine =
    List.foldr (Result.map2 (::)) (Ok [])
