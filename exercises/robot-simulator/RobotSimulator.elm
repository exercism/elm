module RobotSimulator
    exposing
        ( Bearing(East, North, South, West)
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
    Debug.crash "Please implement this function"


turnRight : Robot -> Robot
turnRight robot =
    Debug.crash "Please implement this function"


turnLeft : Robot -> Robot
turnLeft robot =
    Debug.crash "Please implement this function"


advance : Robot -> Robot
advance { bearing, coordinates } =
    Debug.crash "Please implement this function"


simulate : String -> Robot -> Robot
simulate directions robot =
    Debug.crash "Please implement this function"
