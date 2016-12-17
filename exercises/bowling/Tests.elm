port module Main exposing (..)

import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import Bowling


tests : Test
tests =
    describe "Check game can be scored correctly."
        [ test "should be able to score a game with all zeros" <|
            \() ->
                Expect.equal 0
                    (Bowling.rolls [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ])
        , test "should be able to score a game with no strikes or spares" <|
            \() ->
                Expect.equal 90
                    (Bowling.rolls [ 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6 ])
        , test "a spare followed by zeros is worth ten points" <|
            \() ->
                Expect.equal 10
                    (Bowling.rolls [ 6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ])
        , test "points scored in the roll after a spare are counted twice" <|
            \() ->
                Expect.equal 16
                    (Bowling.rolls [ 6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ])
        , test "consecutive spares each get a one roll bonus" <|
            \() ->
                Expect.equal 31
                    (Bowling.rolls [ 5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ])
        , test "a spare in the last frame gets a one roll bonus that is counted once" <|
            \() ->
                Expect.equal 17
                    (Bowling.rolls [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7 ])
        , test "a strike earns ten points in a frame with a single roll" <|
            \() ->
                Expect.equal 10
                    (Bowling.rolls [ 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ])
        , test "points scored in the two rolls after a strike are counted twice as a bonus" <|
            \() ->
                Expect.equal 26
                    (Bowling.rolls [ 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ])
        , test "consecutive strikes each get the two roll bonus" <|
            \() ->
                Expect.equal 81
                    (Bowling.rolls [ 10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ])
        , test "a strike in the last frame gets a two roll bonus that is counted once" <|
            \() ->
                Expect.equal 18
                    (Bowling.rolls [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1 ])
        , test "rolling a spare with the two roll bonus does not get a bonus roll" <|
            \() ->
                Expect.equal 20
                    (Bowling.rolls [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3 ])
        , test "strikes with the two roll bonus do not get bonus rolls" <|
            \() ->
                Expect.equal 30
                    (Bowling.rolls [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10 ])
        , test "a strike with the one roll bonus after a spare in the last frame does not get a bonus" <|
            \() ->
                Expect.equal 20
                    (Bowling.rolls [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10 ])
        , test "all strikes is a perfect game" <|
            \() ->
                Expect.equal 300
                    (Bowling.rolls [ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 ])
        , test "rolls can not score negative points" <|
            \() ->
                Expect.equal -1
                    (Bowling.rolls [ -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ])
        , test "a roll can not score more than 10 points" <|
            \() ->
                Expect.equal -1
                    (Bowling.rolls [ 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ])
        , test "two rolls in a frame can not score more than 10 points" <|
            \() ->
                Expect.equal -1
                    (Bowling.rolls [ 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ])
        , test "bonus roll after a strike in the last frame can not score more than 10 points" <|
            \() ->
                Expect.equal -1
                    (Bowling.rolls [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 11 ])
        , test "two bonus rolls after a strike in the last frame can not score more than 10 points" <|
            \() ->
                Expect.equal -1
                    (Bowling.rolls [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 5, 6 ])
        , test "two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike" <|
            \() ->
                Expect.equal 26
                    (Bowling.rolls [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6 ])
        , test "the second bonus rolls after a strike in the last frame can not be a strike if the first one is not a strike" <|
            \() ->
                Expect.equal -1
                    (Bowling.rolls [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 6, 10 ])
        , test "second bonus roll after a strike in the last frame can not score more than 10 points" <|
            \() ->
                Expect.equal -1
                    (Bowling.rolls [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 11 ])
        , test "an unstarted game can not be scored" <|
            \() ->
                Expect.equal -1
                    (Bowling.rolls [])
        , test "an incomplete game can not be scored" <|
            \() ->
                Expect.equal -1
                    (Bowling.rolls [ 0, 0 ])
        , test "a game with more than ten frames can not be scored" <|
            \() ->
                Expect.equal -1
                    (Bowling.rolls [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ])
        , test "bonus rolls for a strike in the last frame must be rolled before score can be calculated" <|
            \() ->
                Expect.equal -1
                    (Bowling.rolls [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10 ])
        , test "both bonus rolls for a strike in the last frame must be rolled before score can be calculated" <|
            \() ->
                Expect.equal -1
                    (Bowling.rolls [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10 ])
        , test "bonus roll for a spare in the last frame must be rolled before score can be calculated" <|
            \() ->
                Expect.equal -1
                    (Bowling.rolls [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3 ])
        ]


main : Program Value
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
