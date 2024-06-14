module Knapsack exposing (Item, maximumValue)


type alias Item =
    { value : Int
    , weight : Int
    }


maximumValue : Int -> List Item -> Int
maximumValue capacity items =
    Debug.todo "Please implement this function"
