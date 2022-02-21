module Tests exposing (assertionList, tests)

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


anyBearing =
    North


anyCoordinates =
    { x = 0, y = 0 }
