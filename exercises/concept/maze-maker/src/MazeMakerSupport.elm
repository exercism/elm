module MazeMakerSupport exposing (..)

import MazeMaker exposing (Maze(..))


isBranch : Maze -> Bool
isBranch maze =
    case maze of
        DeadEnd ->
            False

        Room _ ->
            False

        Branch _ ->
            True


isRoom : Maze -> Bool
isRoom maze =
    case maze of
        DeadEnd ->
            False

        Room _ ->
            True

        Branch _ ->
            False


branchNumber : Maze -> Int
branchNumber maze =
    case maze of
        DeadEnd ->
            0

        Room _ ->
            0

        Branch mazes ->
            mazes
                |> List.map branchNumber
                |> List.sum
                |> (+) (List.length mazes)


mazeDepth : Maze -> Int
mazeDepth maze =
    case maze of
        DeadEnd ->
            0

        Room _ ->
            0

        Branch mazes ->
            mazes
                |> List.map mazeDepth
                |> List.maximum
                |> Maybe.withDefault 0
                |> (+) 1
