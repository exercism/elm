module Tests exposing (tests)

import Bowling exposing (score)
import Expect
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "{exercise}"
        [ test "should be able to score a game with all zeros" <|
            \_ ->
                Expect.equal (Ok 0) <|
                    score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
        , test "should be able to score a game with no strikes or spares" <|
            \_ ->
                Expect.equal (Ok 90) <|
                    score [ 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6 ]
        , test "a spare followed by zeros is worth ten points" <|
            \_ ->
                Expect.equal (Ok 10) <|
                    score [ 6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
        , test "points scored in the roll after a spare are counted twice" <|
            \_ ->
                Expect.equal (Ok 16) <|
                    score [ 6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
        , test "consecutive spares each get a one roll bonus" <|
            \_ ->
                Expect.equal (Ok 31) <|
                    score [ 5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
        , test "a spare in the last frame gets a one roll bonus that is counted once" <|
            \_ ->
                Expect.equal (Ok 17) <|
                    score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7 ]
        , test "a strike earns ten points in a frame with a single roll" <|
            \_ ->
                Expect.equal (Ok 10) <|
                    score [ 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
        , test "points scored in the two rolls after a strike are counted twice as a bonus" <|
            \_ ->
                Expect.equal (Ok 26) <|
                    score [ 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
        , test "consecutive strikes each get the two roll bonus" <|
            \_ ->
                Expect.equal (Ok 81) <|
                    score [ 10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
        , test "a strike in the last frame gets a two roll bonus that is counted once" <|
            \_ ->
                Expect.equal (Ok 18) <|
                    score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1 ]
        , test "rolling a spare with the two roll bonus does not get a bonus roll" <|
            \_ ->
                Expect.equal (Ok 20) <|
                    score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3 ]
        , test "strikes with the two roll bonus do not get bonus rolls" <|
            \_ ->
                Expect.equal (Ok 30) <|
                    score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10 ]
        , test "a strike with the one roll bonus after a spare in the last frame does not get a bonus" <|
            \_ ->
                Expect.equal (Ok 20) <|
                    score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10 ]
        , test "all strikes is a perfect game" <|
            \_ ->
                Expect.equal (Ok 300) <|
                    score [ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 ]
        , test "rolls cannot score negative points" <|
            \_ ->
                Expect.err <|
                    score [ -1 ]
        , test "a roll cannot score more than 10 points" <|
            \_ ->
                Expect.err <|
                    score [ 11 ]
        , test "two rolls in a frame cannot score more than 10 points" <|
            \_ ->
                Expect.err <|
                    score [ 5, 6 ]
        , test "bonus roll after a strike in the last frame cannot score more than 10 points" <|
            \_ ->
                Expect.err <|
                    score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 11 ]
        , test "two bonus rolls after a strike in the last frame cannot score more than 10 points" <|
            \_ ->
                Expect.err <|
                    score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 5, 6 ]
        , test "two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike" <|
            \_ ->
                Expect.equal (Ok 26) <|
                    score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6 ]
        , test "the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike" <|
            \_ ->
                Expect.err <|
                    score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 6, 10 ]
        , test "second bonus roll after a strike in the last frame cannot score more than 10 points" <|
            \_ ->
                Expect.err <|
                    score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 11 ]
        , test "an unstarted game cannot be scored" <|
            \_ ->
                Expect.err <|
                    score []
        , test "an incomplete game cannot be scored" <|
            \_ ->
                Expect.err <|
                    score [ 0, 0 ]
        , test "cannot roll if game already has ten frames" <|
            \_ ->
                Expect.err <|
                    score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
        , test "bonus rolls for a strike in the last frame must be rolled before score can be calculated" <|
            \_ ->
                Expect.err <|
                    score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10 ]
        , test "both bonus rolls for a strike in the last frame must be rolled before score can be calculated" <|
            \_ ->
                Expect.err <|
                    score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10 ]
        , test "bonus roll for a spare in the last frame must be rolled before score can be calculated" <|
            \_ ->
                Expect.err <|
                    score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3 ]
        , test "cannot roll after bonus roll for spare" <|
            \_ ->
                Expect.err <|
                    score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 2, 2 ]
        , test "cannot roll after bonus rolls for strike" <|
            \_ ->
                Expect.err <|
                    score [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 3, 2, 2 ]
        ]
