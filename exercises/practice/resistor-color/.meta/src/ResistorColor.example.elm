module ResistorColor exposing (colorCode, colors)


colorCode : String -> Int
colorCode color =
    findIndex color colors 0


colors : List String
colors =
    [ "black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white" ]


findIndex : a -> List a -> Int -> Int
findIndex needle haystack acc =
    case haystack of
        [] ->
            -1

        x :: xs ->
            if x == needle then
                acc

            else
                findIndex needle xs (acc + 1)
