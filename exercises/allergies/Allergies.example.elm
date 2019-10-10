module Allergies exposing (Allergy(..), isAllergicTo, toList)

import Bitwise
import List


type Allergy
    = Eggs
    | Peanuts
    | Shellfish
    | Strawberries
    | Tomatoes
    | Chocolate
    | Pollen
    | Cats


isAllergicTo : Allergy -> Int -> Bool
isAllergicTo allergy score =
    List.member allergy (toList score)


toList : Int -> List Allergy
toList score =
    allergies
        |> List.indexedMap (\i n -> ( Bitwise.shiftLeftBy i 1, n ))
        |> List.filter (\( s, n ) -> Bitwise.and s score > 0)
        |> List.map Tuple.second


allergies : List Allergy
allergies =
    [ Eggs
    , Peanuts
    , Shellfish
    , Strawberries
    , Tomatoes
    , Chocolate
    , Pollen
    , Cats
    ]
