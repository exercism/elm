module Knapsack exposing (Item, maximumValue)


type alias Item =
    { value : Int
    , weight : Int
    }


maximumValue : Int -> List Item -> Int
maximumValue capacity items =
    doMaximumValue items (List.repeat (capacity + 1) 0)


last : List Int -> Int
last list =
    List.foldl (\x _ -> x) 0 list


valueAt : List a -> Int -> Maybe a
valueAt list index =
    case list of
        [] ->
            Nothing

        next :: remaining ->
            if index <= 0 then
                Just next

            else
                valueAt remaining (index - 1)


nextRow : Item -> List Int -> List Int
nextRow item lastRow =
    List.indexedMap
        (\availableCapacity value ->
            let
                requiredCapacity =
                    availableCapacity - item.weight
            in
            if requiredCapacity < 0 then
                value

            else
                case valueAt lastRow requiredCapacity of
                    Just existingValue ->
                        max (existingValue + item.value) existingValue

                    Nothing ->
                        value
        )
        lastRow


doMaximumValue : List Item -> List Int -> Int
doMaximumValue items lastRow =
    case items of
        [] ->
            last lastRow

        next :: rest ->
            doMaximumValue rest (nextRow next lastRow)
