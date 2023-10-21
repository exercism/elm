module MazeMaker exposing (..)

import Random exposing (Generator)


type Maze
    = DeadEnd
    | Room Treasure
    | Branch (List Maze)


type Treasure
    = Gold
    | Diamond
    | Friendship


deadend : Generator Maze
deadend =
    Random.lazy (\_ -> Debug.todo "Please implement deadend")


treasure : Generator Treasure
treasure =
    Random.lazy (\_ -> Debug.todo "Please implement treasure")


room : Generator Maze
room =
    Random.lazy (\_ -> Debug.todo "Please implement room")


branch : Generator Maze -> Generator Maze
branch mazeGenerator =
    Random.lazy (\_ -> Debug.todo "Please implement branch")


maze : Generator Maze
maze =
    Random.lazy (\_ -> Debug.todo "Please implement maze")


mazeOfDepth : Int -> Generator Maze
mazeOfDepth depth =
    Random.lazy (\_ -> Debug.todo "Please implement mazeOfDepth")
