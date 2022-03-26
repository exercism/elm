module Tests exposing (tests)

import Expect
import RobotSimulator exposing (Bearing(..), Robot, advance, defaultRobot, simulate, turnLeft, turnRight)
import Test exposing (..)


tests : Test
tests =
    describe "RobotSimulator"
        [ describe "init"
            [ test "coordinates" <|
                \() -> Expect.equal { x = 0, y = 0 } defaultRobot.coordinates
            , test "bearing" <|
                \() -> Expect.equal North defaultRobot.bearing
            ]
        , skip <|
            describe "setup"
                [ test "coordinates" <|
                    \() ->
                        Robot anyBearing { x = -1, y = 1 }
                            |> .coordinates
                            |> Expect.equal { x = -1, y = 1 }
                , test "bearing" <|
                    \() ->
                        Robot South anyCoordinates
                            |> .bearing
                            |> Expect.equal South
                ]
        , skip <|
            test "turn right" <|
                \() ->
                    [ identity, turnRight, turnRight >> turnRight, turnRight >> turnRight >> turnRight ]
                        |> List.map (\turn -> turn defaultRobot |> .bearing)
                        |> Expect.equal [ North, East, South, West ]
        , skip <|
            test "turn left" <|
                \() ->
                    [ identity, turnLeft, turnLeft >> turnLeft, turnLeft >> turnLeft >> turnLeft ]
                        |> List.map (\turn -> turn defaultRobot |> .bearing)
                        |> Expect.equal [ North, West, South, East ]
        , skip <|
            describe "advance positive north"
                [ test "coordinates" <|
                    \() ->
                        Robot North { x = 0, y = 0 }
                            |> advance
                            |> .coordinates
                            |> Expect.equal { x = 0, y = 1 }
                , test "bearing" <|
                    \() ->
                        Robot North { x = 0, y = 0 }
                            |> advance
                            |> .bearing
                            |> Expect.equal North
                ]
        , skip <|
            describe "advance positive east"
                [ test "coordinates" <|
                    \() ->
                        Robot East { x = 0, y = 0 }
                            |> advance
                            |> .coordinates
                            |> Expect.equal { x = 1, y = 0 }
                , test "bearing" <|
                    \() ->
                        Robot East { x = 0, y = 0 }
                            |> advance
                            |> .bearing
                            |> Expect.equal East
                ]
        , skip <|
            describe "advance negative south"
                [ test "coordinates" <|
                    \() ->
                        Robot South { x = 0, y = 0 }
                            |> advance
                            |> .coordinates
                            |> Expect.equal { x = 0, y = -1 }
                , test "bearing" <|
                    \() ->
                        Robot South { x = 0, y = 0 }
                            |> advance
                            |> .bearing
                            |> Expect.equal South
                ]
        , skip <|
            describe "advance positive west"
                [ test "coordinates" <|
                    \() ->
                        Robot West { x = 0, y = 0 }
                            |> advance
                            |> .coordinates
                            |> Expect.equal { x = -1, y = 0 }
                , test "bearing" <|
                    \() ->
                        Robot West { x = 0, y = 0 }
                            |> advance
                            |> .bearing
                            |> Expect.equal West
                ]
        , skip <|
            describe "simulate prog 1"
                [ test "coordinates" <|
                    \() ->
                        Robot North { x = 0, y = 0 }
                            |> simulate "LAAARALA"
                            |> .coordinates
                            |> Expect.equal { x = -4, y = 1 }
                , test "bearing" <|
                    \() ->
                        Robot North { x = 0, y = 0 }
                            |> simulate "LAAARALA"
                            |> .bearing
                            |> Expect.equal West
                ]
        , skip <|
            describe "simulate prog 2"
                [ test "coordinates" <|
                    \() ->
                        Robot East { x = 2, y = -7 }
                            |> simulate "RRAAAAALA"
                            |> .coordinates
                            |> Expect.equal { x = -3, y = -8 }
                , test "bearing" <|
                    \() ->
                        Robot East { x = 2, y = -7 }
                            |> simulate "RRAAAAALA"
                            |> .bearing
                            |> Expect.equal South
                ]
        , skip <|
            describe "simulate prog 3"
                [ test "coordinates" <|
                    \() ->
                        Robot South { x = 8, y = 4 }
                            |> simulate "LAAARRRALLLL"
                            |> .coordinates
                            |> Expect.equal { x = 11, y = 5 }
                , test "bearing" <|
                    \() ->
                        Robot South { x = 8, y = 4 }
                            |> simulate "LAAARRRALLLL"
                            |> .bearing
                            |> Expect.equal North
                ]
        ]


anyBearing =
    North


anyCoordinates =
    { x = 0, y = 0 }
