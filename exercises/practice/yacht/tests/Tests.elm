module Tests exposing (tests)

import Expect
import Test exposing (Test, describe, skip, test)
import Yacht exposing (Category(..))


tests : Test
tests =
    describe "Yacht"
        [ -- skip <|
          test "Is Yacht" <|
            \() ->
                Yacht.score [ 5, 5, 5, 5, 5 ] Yacht
                    |> Expect.equal 50
        , skip <|
            test "Not Yacht" <|
                \() ->
                    Yacht.score [ 1, 3, 3, 2, 5 ] Yacht
                        |> Expect.equal 0
        , skip <|
            test "Ones" <|
                \() ->
                    Yacht.score [ 1, 1, 1, 3, 5 ] Ones
                        |> Expect.equal 3
        , skip <|
            test "Ones, out of order" <|
                \() ->
                    Yacht.score [ 3, 1, 1, 5, 1 ] Ones
                        |> Expect.equal 3
        , skip <|
            test "No ones" <|
                \() ->
                    Yacht.score [ 4, 3, 6, 5, 5 ] Ones
                        |> Expect.equal 0
        , skip <|
            test "Twos" <|
                \() ->
                    Yacht.score [ 2, 3, 4, 5, 6 ] Twos
                        |> Expect.equal 2
        , skip <|
            test "Fours" <|
                \() ->
                    Yacht.score [ 1, 4, 1, 4, 1 ] Fours
                        |> Expect.equal 8
        , skip <|
            test "Yacht counted as threes" <|
                \() ->
                    Yacht.score [ 3, 3, 3, 3, 3 ] Threes
                        |> Expect.equal 15
        , skip <|
            test "Yacht of 3s counted as fives" <|
                \() ->
                    Yacht.score [ 3, 3, 3, 3, 3 ] Fives
                        |> Expect.equal 0
        , skip <|
            test "Fives" <|
                \() ->
                    Yacht.score [ 1, 5, 3, 5, 3 ] Fives
                        |> Expect.equal 10
        , skip <|
            test "Sixes" <|
                \() ->
                    Yacht.score [ 2, 3, 4, 5, 6 ] Sixes
                        |> Expect.equal 6
        , skip <|
            test "Full house two small, three big" <|
                \() ->
                    Yacht.score [ 2, 2, 4, 4, 4 ] FullHouse
                        |> Expect.equal 16
        , skip <|
            test "Full house three small, two big" <|
                \() ->
                    Yacht.score [ 5, 3, 3, 5, 3 ] FullHouse
                        |> Expect.equal 19
        , skip <|
            test "Two pair is not a full house" <|
                \() ->
                    Yacht.score [ 2, 2, 4, 4, 5 ] FullHouse
                        |> Expect.equal 0
        , skip <|
            test "Four of a kind is not a full house" <|
                \() ->
                    Yacht.score [ 1, 4, 4, 4, 4 ] FullHouse
                        |> Expect.equal 0
        , skip <|
            test "Yacht is not a full house" <|
                \() ->
                    Yacht.score [ 2, 2, 2, 2, 2 ] FullHouse
                        |> Expect.equal 0
        , skip <|
            test "Four of a Kind" <|
                \() ->
                    Yacht.score [ 6, 6, 4, 6, 6 ] FourOfAKind
                        |> Expect.equal 24
        , skip <|
            test "Yacht can be scored as Four of a Kind" <|
                \() ->
                    Yacht.score [ 3, 3, 3, 3, 3 ] FourOfAKind
                        |> Expect.equal 12
        , skip <|
            test "Full house is not Four of a Kind" <|
                \() ->
                    Yacht.score [ 3, 3, 3, 5, 5 ] FourOfAKind
                        |> Expect.equal 0
        , skip <|
            test "Little Straight" <|
                \() ->
                    Yacht.score [ 3, 5, 4, 1, 2 ] LittleStraight
                        |> Expect.equal 30
        , skip <|
            test "Little Straight as Big Straight" <|
                \() ->
                    Yacht.score [ 1, 2, 3, 4, 5 ] BigStraight
                        |> Expect.equal 0
        , skip <|
            test "Four in order but not a little straight" <|
                \() ->
                    Yacht.score [ 1, 1, 2, 3, 4 ] LittleStraight
                        |> Expect.equal 0
        , skip <|
            test "No pairs but not a little straight" <|
                \() ->
                    Yacht.score [ 1, 2, 3, 4, 6 ] LittleStraight
                        |> Expect.equal 0
        , skip <|
            test "Minimum is 1, maximum is 5, but not a little straight" <|
                \() ->
                    Yacht.score [ 1, 1, 3, 4, 5 ] LittleStraight
                        |> Expect.equal 0
        , skip <|
            test "Big Straight" <|
                \() ->
                    Yacht.score [ 4, 6, 2, 5, 3 ] BigStraight
                        |> Expect.equal 30
        , skip <|
            test "Big Straight as little straight" <|
                \() ->
                    Yacht.score [ 6, 5, 4, 3, 2 ] LittleStraight
                        |> Expect.equal 0
        , skip <|
            test "No pairs but not a big straight" <|
                \() ->
                    Yacht.score [ 6, 5, 4, 3, 1 ] BigStraight
                        |> Expect.equal 0
        , skip <|
            test "Choice" <|
                \() ->
                    Yacht.score [ 3, 3, 5, 6, 6 ] Choice
                        |> Expect.equal 23
        , skip <|
            test "Yacht as choice" <|
                \() ->
                    Yacht.score [ 2, 2, 2, 2, 2 ] Choice
                        |> Expect.equal 10
        ]
