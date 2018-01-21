module RobotSimulator exposing (..)

import String


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
    case robot.bearing of
        North ->
            { robot | bearing = East }

        East ->
            { robot | bearing = South }

        South ->
            { robot | bearing = West }

        West ->
            { robot | bearing = North }


turnLeft : Robot -> Robot
turnLeft robot =
    case robot.bearing of
        North ->
            { robot | bearing = West }

        West ->
            { robot | bearing = South }

        South ->
            { robot | bearing = East }

        East ->
            { robot | bearing = North }


advance : Robot -> Robot
advance { bearing, coordinates } =
    let
        updated =
            case bearing of
                North ->
                    { coordinates | y = coordinates.y + 1 }

                East ->
                    { coordinates | x = coordinates.x + 1 }

                South ->
                    { coordinates | y = coordinates.y - 1 }

                West ->
                    { coordinates | x = coordinates.x - 1 }
    in
    { bearing = bearing, coordinates = updated }


simulate : String -> Robot -> Robot
simulate directions robot =
    let
        action direction =
            case direction of
                'L' ->
                    turnLeft

                'R' ->
                    turnRight

                'A' ->
                    advance

                _ ->
                    identity
    in
    directions
        |> String.toList
        |> List.map action
        |> List.foldl (\a r -> a r) robot
