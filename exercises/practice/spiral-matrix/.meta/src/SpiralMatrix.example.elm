module SpiralMatrix exposing (spiralMatrix)

import Dict exposing (Dict)


type Direction
    = Left
    | Right
    | Up
    | Down


spiralMatrix : Int -> List (List Int)
spiralMatrix size =
    buildCells size
        |> Dict.values
        |> splitInChunks size


buildCells : Int -> Dict ( Int, Int ) Int
buildCells size =
    let
        turnRight direction =
            case direction of
                Left ->
                    Up

                Right ->
                    Down

                Up ->
                    Right

                Down ->
                    Left

        nextPosition ( row, col, direction ) cells =
            let
                ( newRow, newCol ) =
                    case direction of
                        Left ->
                            ( row, col - 1 )

                        Right ->
                            ( row, col + 1 )

                        Up ->
                            ( row - 1, col )

                        Down ->
                            ( row + 1, col )
            in
            if newRow > size || newCol > size || newRow <= 0 || newCol <= 0 || Dict.member ( newRow, newCol ) cells then
                nextPosition ( row, col, turnRight direction ) cells

            else
                ( newRow, newCol, direction )

        build (( row, col, _ ) as position) value cells =
            if value > size * size then
                cells

            else if value == size * size then
                Dict.insert ( row, col ) value cells

            else
                build (nextPosition position cells) (value + 1) (Dict.insert ( row, col ) value cells)
    in
    build ( 1, 1, Right ) 1 Dict.empty


splitInChunks : Int -> List a -> List (List a)
splitInChunks size originalList =
    let
        split list chunks =
            case list of
                [] ->
                    List.reverse chunks

                _ ->
                    split (List.drop size list) (List.take size list :: chunks)
    in
    split originalList []
