module Main exposing (..)

import ElmTest exposing (..)
import RobotSimulator exposing (defaultRobot, Robot, Bearing(North, East, West, South), turnRight, turnLeft, advance, simulate)


tests : Test
tests =
    suite "RobotSimulator"
        [ suite "init"
            (let
                robot =
                    defaultRobot
             in
                [ test "coordinates" (assertEqual { x = 0, y = 0 } robot.coordinates)
                , test "bearing" (assertEqual North robot.bearing)
                ]
            )
        , suite "setup"
            (let
                robot =
                    Robot South { x = -1, y = 1 }
             in
                [ test "coordinates" (assertEqual { x = -1, y = 1 } robot.coordinates)
                , test "bearing" (assertEqual South robot.bearing)
                ]
            )
        , suite "turn right"
            ([1..3]
                |> List.scanl (\_ r -> turnRight r) defaultRobot
                |> List.map .bearing
                |> assertionList [ North, East, South, West ]
                |> List.map defaultTest
            )
        , suite "turn left"
            ([1..3]
                |> List.scanl (\_ r -> turnLeft r) defaultRobot
                |> List.map .bearing
                |> assertionList [ North, West, South, East ]
                |> List.map defaultTest
            )
        , suite "advance positive north"
            (let
                robot =
                    Robot North { x = 0, y = 0 }
                        |> advance
             in
                [ test "coordinates" (assertEqual { x = 0, y = 1 } robot.coordinates)
                , test "bearing" (assertEqual North robot.bearing)
                ]
            )
        , suite "advance positive east"
            (let
                robot =
                    Robot East { x = 0, y = 0 }
                        |> advance
             in
                [ test "coordinates" (assertEqual { x = 1, y = 0 } robot.coordinates)
                , test "bearing" (assertEqual East robot.bearing)
                ]
            )
        , suite "advance negative south"
            (let
                robot =
                    Robot South { x = 0, y = 0 }
                        |> advance
             in
                [ test "coordinates" (assertEqual { x = 0, y = -1 } robot.coordinates)
                , test "bearing" (assertEqual South robot.bearing)
                ]
            )
        , suite "advance positive west"
            (let
                robot =
                    Robot West { x = 0, y = 0 }
                        |> advance
             in
                [ test "coordinates" (assertEqual { x = -1, y = 0 } robot.coordinates)
                , test "bearing" (assertEqual West robot.bearing)
                ]
            )
        , suite "simulate prog 1"
            (let
                robot =
                    Robot North { x = 0, y = 0 }
                        |> simulate "LAAARALA"
             in
                [ test "coordinates" (assertEqual { x = -4, y = 1 } robot.coordinates)
                , test "bearing" (assertEqual West robot.bearing)
                ]
            )
        , suite "simulate prog 2"
            (let
                robot =
                    Robot East { x = 2, y = -7 }
                        |> simulate "RRAAAAALA"
             in
                [ test "coordinates" (assertEqual { x = -3, y = -8 } robot.coordinates)
                , test "bearing" (assertEqual South robot.bearing)
                ]
            )
        , suite "simulate prog 3"
            (let
                robot =
                    Robot South { x = 8, y = 4 }
                        |> simulate "LAAARRRALLLL"
             in
                [ test "coordinates" (assertEqual { x = 11, y = 5 } robot.coordinates)
                , test "bearing" (assertEqual North robot.bearing)
                ]
            )
        ]


main : Program Never
main =
    runSuite tests
