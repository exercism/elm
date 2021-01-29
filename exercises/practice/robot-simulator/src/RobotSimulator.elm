module RobotSimulator exposing
    ( Bearing(..)
    , Robot
    , advance
    , defaultRobot
    , simulate
    , turnLeft
    , turnRight
    )


type Bearing
    = North
    | East
    | South
    | West


type alias Robot =
    { bearing : Bearing
    , coordinates : { x : Int, y : Int }
    }


defaultRobot : Robot
defaultRobot =
    { bearing = North
    , coordinates = { x = 0, y = 0 }
    }


turnRight : Robot -> Robot
turnRight robot =
    Debug.todo "Please implement this function"


turnLeft : Robot -> Robot
turnLeft robot =
    Debug.todo "Please implement this function"


advance : Robot -> Robot
advance robot =
    Debug.todo "Please implement this function"


simulate : String -> Robot -> Robot
simulate directions robot =
    Debug.todo "Please implement this function"
