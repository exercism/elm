port module Main exposing (..)

import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import RobotSimulator exposing (defaultRobot, Robot, Bearing(North, East, West, South), turnRight, turnLeft, advance, simulate)


tests : Test
tests =
    describe "RobotSimulator"
        [ describe "init"
            (let
                robot =
                    defaultRobot
             in
                [ test "coordinates" <|
                    \() -> Expect.equal { x = 0, y = 0 } robot.coordinates
                , test "bearing" <|
                    \() -> Expect.equal North robot.bearing
                ]
            )
        , describe "setup"
            (let
                robot =
                    Robot South { x = -1, y = 1 }
             in
                [ test "coordinates" <|
                    \() -> Expect.equal { x = -1, y = 1 } robot.coordinates
                , test "bearing" <|
                    \() -> Expect.equal South robot.bearing
                ]
            )
        , describe "turn right"
            ([1..3]
                |> List.scanl (\_ r -> turnRight r) defaultRobot
                |> List.map .bearing
                |> assertionList [ North, East, South, West ]
                |> List.indexedMap (\i e -> test ("step " ++ toString i) (\() -> e))
            )
        , describe
            "turn left"
            ([1..3]
                |> List.scanl (\_ r -> turnLeft r) defaultRobot
                |> List.map .bearing
                |> assertionList [ North, West, South, East ]
                |> List.indexedMap (\i e -> test ("step " ++ toString i) (\() -> e))
            )
        , describe "advance positive north"
            (let
                robot =
                    Robot North { x = 0, y = 0 }
                        |> advance
             in
                [ test "coordinates" <|
                    \() -> Expect.equal { x = 0, y = 1 } robot.coordinates
                , test "bearing" <|
                    \() -> Expect.equal North robot.bearing
                ]
            )
        , describe "advance positive east"
            (let
                robot =
                    Robot East { x = 0, y = 0 }
                        |> advance
             in
                [ test "coordinates" <|
                    \() -> Expect.equal { x = 1, y = 0 } robot.coordinates
                , test "bearing" <|
                    \() -> Expect.equal East robot.bearing
                ]
            )
        , describe "advance negative south"
            (let
                robot =
                    Robot South { x = 0, y = 0 }
                        |> advance
             in
                [ test "coordinates" <|
                    \() -> Expect.equal { x = 0, y = -1 } robot.coordinates
                , test "bearing" <|
                    \() -> Expect.equal South robot.bearing
                ]
            )
        , describe "advance positive west"
            (let
                robot =
                    Robot West { x = 0, y = 0 }
                        |> advance
             in
                [ test "coordinates" <|
                    \() -> Expect.equal { x = -1, y = 0 } robot.coordinates
                , test "bearing" <|
                    \() -> Expect.equal West robot.bearing
                ]
            )
        , describe "simulate prog 1"
            (let
                robot =
                    Robot North { x = 0, y = 0 }
                        |> simulate "LAAARALA"
             in
                [ test "coordinates" <|
                    \() -> Expect.equal { x = -4, y = 1 } robot.coordinates
                , test "bearing" <|
                    \() -> Expect.equal West robot.bearing
                ]
            )
        , describe "simulate prog 2"
            (let
                robot =
                    Robot East { x = 2, y = -7 }
                        |> simulate "RRAAAAALA"
             in
                [ test "coordinates" <|
                    \() -> Expect.equal { x = -3, y = -8 } robot.coordinates
                , test "bearing" <|
                    \() -> Expect.equal South robot.bearing
                ]
            )
        , describe "simulate prog 3"
            (let
                robot =
                    Robot South { x = 8, y = 4 }
                        |> simulate "LAAARRRALLLL"
             in
                [ test "coordinates" <|
                    \() -> Expect.equal { x = 11, y = 5 } robot.coordinates
                , test "bearing" <|
                    \() -> Expect.equal North robot.bearing
                ]
            )
        ]


{-| Given a list of values and another list of expected values,
generate a list of Assert Equal assertions.
-}
assertionList : List a -> List a -> List Expect.Expectation
assertionList xs ys =
    List.map2 Expect.equal xs ys


main : Program Value
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
