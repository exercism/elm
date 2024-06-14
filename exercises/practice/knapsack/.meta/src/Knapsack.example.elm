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


valueAt : List a -> Int -> Result String a
valueAt list index =
    case list of
        [] ->
            Err "Index out of bounds"

        n :: rem ->
            if index == 0 then
                Ok n

            else
                valueAt rem (index - 1)


nextRow : Item -> List Int -> List Int
nextRow item lastRow =
    List.indexedMap
        (\cap val ->
            let
                req =
                    cap - item.weight
            in
            if req < 0 then
                val

            else
                case valueAt lastRow req of
                    Ok v ->
                        let
                            withItem =
                                v + item.value
                        in
                        if withItem > val then
                            withItem

                        else
                            val

                    Err _ ->
                        val
        )
        lastRow


doMaximumValue : List Item -> List Int -> Int
doMaximumValue items lastRow =
    case items of
        [] ->
            last lastRow

        n :: rest ->
            doMaximumValue rest (nextRow n lastRow)
