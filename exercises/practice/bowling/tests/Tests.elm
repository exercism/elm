module Tests exposing (tests)

import Bowling exposing (score)
import Expect
import Test exposing (Test, describe, test)


tests : Test
tests =
    describe "Bowling Score"
        [ test "should be able to score a game with all zeros" <|
            \_ ->
                score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                    |> Expect.equal (Just 0)
        , test "should be able to score a game with no strikes or spares" <|
            \_ ->
                score [ 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6 ]
                    |> Expect.equal (Just 90)
        , test "a spare followed by zeros is worth ten points" <|
            \_ ->
                score [ 6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                    |> Expect.equal (Just 10)
        , test "points scored in the roll after a spare are counted twice" <|
            \_ ->
                score [ 6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                    |> Expect.equal (Just 16)
        , test "consecutive spares each get a one roll bonus" <|
            \_ ->
                score [ 5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                    |> Expect.equal (Just 31)
        , test "a spare in the last frame gets a one roll bonus that is counted once" <|
            \_ ->
                score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7 ]
                    |> Expect.equal (Just 17)
        , test "a strike earns ten points in a frame with a single roll" <|
            \_ ->
                score [ 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                    |> Expect.equal (Just 10)
        , test "points scored in the two rolls after a strike are counted twice as a bonus" <|
            \_ ->
                score [ 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                    |> Expect.equal (Just 26)
        , test "consecutive strikes each get the two roll bonus" <|
            \_ ->
                score [ 10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                    |> Expect.equal (Just 81)
        , test "a strike in the last frame gets a two roll bonus that is counted once" <|
            \_ ->
                score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1 ]
                    |> Expect.equal (Just 18)
        , test "rolling a spare with the two roll bonus does not get a bonus roll" <|
            \_ ->
                score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3 ]
                    |> Expect.equal (Just 20)
        , test "strikes with the two roll bonus do not get bonus rolls" <|
            \_ ->
                score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10 ]
                    |> Expect.equal (Just 30)
        , test "a strike with the one roll bonus after a spare in the last frame does not get a bonus" <|
            \_ ->
                score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10 ]
                    |> Expect.equal (Just 20)
        , test "all strikes is a perfect game" <|
            \_ ->
                score [ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 ]
                    |> Expect.equal (Just 300)
        , test "rolls cannot score negative points" <|
            \_ ->
                score [ -1 ]
                    |> Expect.equal Nothing
        , test "a roll cannot score more than 10 points" <|
            \_ ->
                score [ 11 ]
                    |> Expect.equal Nothing
        , test "two rolls in a frame cannot score more than 10 points" <|
            \_ ->
                score [ 5, 6 ]
                    |> Expect.equal Nothing
        , test "bonus roll after a strike in the last frame cannot score more than 10 points" <|
            \_ ->
                score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 11 ]
                    |> Expect.equal Nothing
        , test "two bonus rolls after a strike in the last frame cannot score more than 10 points" <|
            \_ ->
                score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 5, 6 ]
                    |> Expect.equal Nothing
        , test "two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike" <|
            \_ ->
                score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6 ]
                    |> Expect.equal (Just 26)
        , test "the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike" <|
            \_ ->
                score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 6, 10 ]
                    |> Expect.equal Nothing
        , test "second bonus roll after a strike in the last frame cannot score more than 10 points" <|
            \_ ->
                score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 11 ]
                    |> Expect.equal Nothing
        , test "an unstarted game cannot be scored" <|
            \_ ->
                score []
                    |> Expect.equal Nothing
        , test "an incomplete game cannot be scored" <|
            \_ ->
                score [ 0, 0 ]
                    |> Expect.equal Nothing
        , test "cannot roll if game already has ten frames" <|
            \_ ->
                score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
                    |> Expect.equal Nothing
        , test "bonus rolls for a strike in the last frame must be rolled before score can be calculated" <|
            \_ ->
                score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10 ]
                    |> Expect.equal Nothing
        , test "both bonus rolls for a strike in the last frame must be rolled before score can be calculated" <|
            \_ ->
                score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10 ]
                    |> Expect.equal Nothing
        , test "bonus roll for a spare in the last frame must be rolled before score can be calculated" <|
            \_ ->
                score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3 ]
                    |> Expect.equal Nothing
        , test "cannot roll after bonus roll for spare" <|
            \_ ->
                score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 2, 2 ]
                    |> Expect.equal Nothing
        , test "cannot roll after bonus rolls for strike" <|
            \_ ->
                score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 3, 2, 2 ]
                    |> Expect.equal Nothing
        ]
