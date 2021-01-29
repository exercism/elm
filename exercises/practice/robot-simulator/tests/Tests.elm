module Tests exposing (assertionList, tests)

import Expect
import RobotSimulator exposing (Bearing(..), Robot, advance, defaultRobot, simulate, turnLeft, turnRight)
import Test exposing (..)


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
             , skip <|
                test "bearing" <|
                    \() -> Expect.equal North robot.bearing
             ]
            )
        , describe "setup"
            (let
                robot =
                    Robot South { x = -1, y = 1 }
             in
             [ skip <|
                test "coordinates" <|
                    \() -> Expect.equal { x = -1, y = 1 } robot.coordinates
             , skip <|
                test "bearing" <|
                    \() -> Expect.equal South robot.bearing
             ]
            )
        , skip <|
            describe "turn right"
                (List.range 1 3
                    |> scanl (\_ r -> turnRight r) defaultRobot
                    |> List.map .bearing
                    |> assertionList [ North, East, South, West ]
                    |> List.indexedMap (\i e -> test ("step " ++ String.fromInt i) (\() -> e))
                )
        , skip <|
            describe
                "turn left"
                (List.range 1 3
                    |> scanl (\_ r -> turnLeft r) defaultRobot
                    |> List.map .bearing
                    |> assertionList [ North, West, South, East ]
                    |> List.indexedMap (\i e -> test ("step " ++ String.fromInt i) (\() -> e))
                )
        , describe "advance positive north"
            (let
                robot =
                    Robot North { x = 0, y = 0 }
                        |> advance
             in
             [ skip <|
                test "coordinates" <|
                    \() -> Expect.equal { x = 0, y = 1 } robot.coordinates
             , skip <|
                test "bearing" <|
                    \() -> Expect.equal North robot.bearing
             ]
            )
        , describe "advance positive east"
            (let
                robot =
                    Robot East { x = 0, y = 0 }
                        |> advance
             in
             [ skip <|
                test "coordinates" <|
                    \() -> Expect.equal { x = 1, y = 0 } robot.coordinates
             , skip <|
                test "bearing" <|
                    \() -> Expect.equal East robot.bearing
             ]
            )
        , describe "advance negative south"
            (let
                robot =
                    Robot South { x = 0, y = 0 }
                        |> advance
             in
             [ skip <|
                test "coordinates" <|
                    \() -> Expect.equal { x = 0, y = -1 } robot.coordinates
             , skip <|
                test "bearing" <|
                    \() -> Expect.equal South robot.bearing
             ]
            )
        , describe "advance positive west"
            (let
                robot =
                    Robot West { x = 0, y = 0 }
                        |> advance
             in
             [ skip <|
                test "coordinates" <|
                    \() -> Expect.equal { x = -1, y = 0 } robot.coordinates
             , skip <|
                test "bearing" <|
                    \() -> Expect.equal West robot.bearing
             ]
            )
        , describe "simulate prog 1"
            (let
                robot =
                    Robot North { x = 0, y = 0 }
                        |> simulate "LAAARALA"
             in
             [ skip <|
                test "coordinates" <|
                    \() -> Expect.equal { x = -4, y = 1 } robot.coordinates
             , skip <|
                test "bearing" <|
                    \() -> Expect.equal West robot.bearing
             ]
            )
        , describe "simulate prog 2"
            (let
                robot =
                    Robot East { x = 2, y = -7 }
                        |> simulate "RRAAAAALA"
             in
             [ skip <|
                test "coordinates" <|
                    \() -> Expect.equal { x = -3, y = -8 } robot.coordinates
             , skip <|
                test "bearing" <|
                    \() -> Expect.equal South robot.bearing
             ]
            )
        , describe "simulate prog 3"
            (let
                robot =
                    Robot South { x = 8, y = 4 }
                        |> simulate "LAAARRRALLLL"
             in
             [ skip <|
                test "coordinates" <|
                    \() -> Expect.equal { x = 11, y = 5 } robot.coordinates
             , skip <|
                test "bearing" <|
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


{-| Taken from 0.18's List.scanl for easier upgrade to 0.19
<https://github.com/elm-lang/core/blob/5.1.1/src/List.elm#L171>
-}
scanl : (a -> b -> b) -> b -> List a -> List b
scanl f b xs =
    let
        scan1 x accAcc =
            case accAcc of
                acc :: _ ->
                    f x acc :: accAcc

                [] ->
                    []

        -- impossible
    in
    List.reverse (List.foldl scan1 [ b ] xs)
