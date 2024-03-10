module Minesweeper exposing (annotate)

import Dict exposing (Dict)


type Tile
    = Empty
    | Bomb
    | Annotated Int


annotate : String -> String
annotate minefield =
    let
        positionMap =
            makePositionMap minefield
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
                                    ( ( row, column ), Bomb )

                                _ ->
                                    ( ( row, column ), Empty )
                        )
            )
        |> List.concat
        |> Dict.fromList


annotateTile : Dict ( Int, Int ) Tile -> ( Int, Int ) -> Tile -> Tile
annotateTile minefield ( row, col ) tile =
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
                |> List.filter (\p -> Dict.get p minefield == Just Bomb)
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
        Bomb ->
            "*"

        Empty ->
            "."

        Annotated 0 ->
            "."

        Annotated count ->
            String.fromInt count
