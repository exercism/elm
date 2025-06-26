module FlowerField exposing (annotate)

import Dict exposing (Dict)


type Tile
    = Empty
    | Flower
    | Annotated Int


annotate : String -> String
annotate garden =
    let
        positionMap =
            makePositionMap garden
    in
    positionMap
        |> Dict.map (annotateTile positionMap)
        |> mergeRows
        |> Dict.values
        |> List.map (List.map printTile >> String.concat)
        |> String.join "\n"


makePositionMap : String -> Dict ( Int, Int ) Tile
makePositionMap input =
    input
        |> String.lines
        |> List.indexedMap
            (\row line ->
                line
                    |> String.toList
                    |> List.indexedMap
                        (\column char ->
                            case char of
                                '*' ->
                                    ( ( row, column ), Flower )

                                _ ->
                                    ( ( row, column ), Empty )
                        )
            )
        |> List.concat
        |> Dict.fromList


annotateTile : Dict ( Int, Int ) Tile -> ( Int, Int ) -> Tile -> Tile
annotateTile garden ( row, col ) tile =
    case tile of
        Empty ->
            [ ( row + 1, col + 1 )
            , ( row + 1, col )
            , ( row + 1, col - 1 )
            , ( row, col + 1 )
            , ( row, col - 1 )
            , ( row - 1, col + 1 )
            , ( row - 1, col )
            , ( row - 1, col - 1 )
            ]
                |> List.filter (\p -> Dict.get p garden == Just Flower)
                |> List.length
                |> Annotated

        other ->
            other


mergeRows : Dict ( Int, Int ) Tile -> Dict Int (List Tile)
mergeRows =
    Dict.foldl
        -- we rely on Dict.foldl traversing the keys in order
        (\( row, _ ) tile rows ->
            Dict.update row
                (\line -> Just (tile :: Maybe.withDefault [] line))
                rows
        )
        Dict.empty
        >> Dict.map (always List.reverse)


printTile : Tile -> String
printTile tile =
    case tile of
        Flower ->
            "*"

        Empty ->
            "."

        Annotated 0 ->
            "."

        Annotated count ->
            String.fromInt count
