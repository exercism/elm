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
    Debug.todo "Please implement deadend"


treasure : Generator Treasure
treasure =
    Debug.todo "Please implement treasure"


room : Generator Maze
room =
    Debug.todo "Please implement room"


branch : Generator Maze -> Generator Maze
branch mazeGenerator =
    Debug.todo "Please implement branch"


maze : Generator Maze
maze =
    Debug.todo "Please implement maze"


mazeOfDepth : Int -> Generator Maze
mazeOfDepth depth =
    Debug.todo "Please implement mazeOfDepth"
