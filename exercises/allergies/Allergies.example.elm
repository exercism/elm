module Allergies exposing (isAllergicTo, toList)

import Bitwise
import List


isAllergicTo : String -> Int -> Bool
isAllergicTo name score =
    List.member name (toList score)


toList : Int -> List String
toList score =
    allergies
        |> List.indexedMap (\i n -> ( Bitwise.shiftLeftBy i 1, n ))
        |> List.filter (\( s, n ) -> Bitwise.and s score > 0)
        |> List.map Tuple.second


allergies : List String
allergies =
    [ "eggs"
    , "peanuts"
    , "shellfish"
    , "strawberries"
    , "tomatoes"
    , "chocolate"
    , "pollen"
    , "cats"
    ]
