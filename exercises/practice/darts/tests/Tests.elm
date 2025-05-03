module Tests exposing (tests)

import Darts
import Expect
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "Darts"
        [ test "Missed target" <|
            \() ->
                Darts.score -9 9
                    |> Expect.equal 0
        , skip <|
            test "On the outer circle" <|
                \() ->
                    Darts.score 0 10
                        |> Expect.equal 1
        , skip <|
            test "On the middle circle" <|
                \() ->
                    Darts.score -5 0
                        |> Expect.equal 5
        , skip <|
            test "On the inner circle" <|
                \() ->
                    Darts.score 0 -1
                        |> Expect.equal 10
        , skip <|
            test "Exactly on center" <|
                \() ->
                    Darts.score 0 0
                        |> Expect.equal 10
        , skip <|
            test "Near the center" <|
                \() ->
                    Darts.score -0.1 -0.1
                        |> Expect.equal 10
        , skip <|
            test "Just within the inner circle" <|
                \() ->
                    Darts.score 0.7 0.7
                        |> Expect.equal 10
        , skip <|
            test "Just outside the inner circle" <|
                \() ->
                    Darts.score 0.8 -0.8
                        |> Expect.equal 5
        , skip <|
            test "Just within the middle circle" <|
                \() ->
                    Darts.score -3.5 3.5
                        |> Expect.equal 5
        , skip <|
            test "Just outside the middle circle" <|
                \() ->
                    Darts.score -3.6 -3.6
                        |> Expect.equal 1
        , skip <|
            test "Just within the outer circle" <|
                \() ->
                    Darts.score -7 7
                        |> Expect.equal 1
        , skip <|
            test "Just outside the outer circle" <|
                \() ->
                    Darts.score 7.1 -7.1
                        |> Expect.equal 0
        , skip <|
            test "Asymmetric position between the inner and middle circles" <|
                \() ->
                    Darts.score 0.5 -4
                        |> Expect.equal 5
        ]
