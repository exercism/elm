module ResistorColorDuo exposing (value)


value : List String -> Int
value colors =
    case colors of
        first :: second :: _ ->
            colorCode first * 10 + colorCode second

        _ ->
            -1


colorCode : String -> Int
colorCode color =
    let
        position =
            bands
                |> List.indexedMap (\i x -> ( i, x ))
                |> List.filter (\( _, elem ) -> elem == color)
                |> List.head
    in
    case position of
        Just ( i, _ ) ->
            i

        Nothing ->
            -1


bands : List String
bands =
    [ "black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white" ]
