module Tests exposing (tests)

import Expect
import Fuzz
import MazeMaker exposing (Maze(..), Treasure(..), branch)
import MazeMakerSupport
import Parser exposing (Step(..))
import Random
import Test exposing (Test, describe, fuzz, fuzzWith)
import Test.Distribution


tests : Test
tests =
    describe "MazeMaker"
        [ describe "1"
            [ fuzz (Fuzz.fromGenerator MazeMaker.deadend)
                "deadend always generates a Deadend"
              <|
                \deadend -> deadend |> Expect.equal DeadEnd
            ]
        , describe "task 2"
            [ fuzzWith
                { runs = 100
                , distribution =
                    Test.expectDistribution
                        [ ( Test.Distribution.atLeast 30, "is Friendship", (==) Friendship )
                        , ( Test.Distribution.atLeast 30, "is Gold", (==) Gold )
                        , ( Test.Distribution.atLeast 30, "is Diamond", (==) Diamond )
                        ]
                }
                (Fuzz.fromGenerator MazeMaker.treasure)
                "treasure generates all three kinds of Treasure equally"
              <|
                \_ -> Expect.pass
            , fuzzWith
                { runs = 100
                , distribution =
                    Test.expectDistribution
                        [ ( Test.Distribution.atLeast 30, "is Room Friendship", (==) (Room Friendship) )
                        , ( Test.Distribution.atLeast 30, "is Room Gold", (==) (Room Gold) )
                        , ( Test.Distribution.atLeast 30, "is Room Diamond", (==) (Room Diamond) )
                        ]
                }
                (Fuzz.fromGenerator MazeMaker.room)
                "room generates a Room with all three kinds of Treasure equally represented"
              <|
                \_ -> Expect.pass
            ]
        , describe "3"
            [ fuzz
                (Fuzz.fromGenerator (MazeMaker.branch MazeMaker.deadend))
                "branch generates a Branch variant"
              <|
                \branch -> MazeMakerSupport.isBranch branch |> Expect.equal True
            , fuzz
                (Fuzz.fromGenerator (MazeMaker.branch MazeMaker.deadend))
                "branch generates branches with deadends"
              <|
                \branch ->
                    case branch of
                        Branch branches ->
                            List.all ((==) DeadEnd) branches |> Expect.equal True

                        _ ->
                            Expect.fail "should only generate a Branch"
            , fuzz
                (Fuzz.fromGenerator (MazeMaker.branch MazeMaker.room))
                "branch generates branches with rooms"
              <|
                \branch ->
                    case branch of
                        Branch branches ->
                            List.all MazeMakerSupport.isRoom branches |> Expect.equal True

                        _ ->
                            Expect.fail "should only generate a Branch"
            , fuzz
                (Fuzz.fromGenerator (MazeMaker.branch MazeMaker.deadend))
                "branch generates at least two branches"
              <|
                \branch -> MazeMakerSupport.branchNumber branch |> Expect.atLeast 2
            , fuzz
                (Fuzz.fromGenerator (MazeMaker.branch MazeMaker.deadend))
                "branch generates at most four branches"
              <|
                \branch -> MazeMakerSupport.branchNumber branch |> Expect.atMost 4
            , fuzzWith
                { runs = 100
                , distribution =
                    Test.expectDistribution
                        [ ( Test.Distribution.atLeast 30, "has 2 branches", (==) 2 )
                        , ( Test.Distribution.atLeast 30, "has 3 branches", (==) 3 )
                        , ( Test.Distribution.atLeast 30, "has 4 branches", (==) 4 )
                        ]
                }
                (Fuzz.fromGenerator (MazeMaker.branch MazeMaker.deadend |> Random.map MazeMakerSupport.branchNumber))
                "branch generates 2, 3, or 4 branches equally"
              <|
                \_ -> Expect.pass
            ]
        , describe "4"
            [ fuzzWith
                { runs = 100
                , distribution =
                    Test.expectDistribution
                        [ ( Test.Distribution.atLeast 50, "is a deadend", (==) DeadEnd )
                        , ( Test.Distribution.atLeast 10, "is a room", MazeMakerSupport.isRoom )
                        , ( Test.Distribution.atLeast 20, "is a branch", MazeMakerSupport.isBranch )
                        ]
                }
                (Fuzz.fromGenerator MazeMaker.maze)
                "generates 60% or deadends, 15% of rooms and 25% of branches"
              <|
                \_ -> Expect.pass
            , fuzzWith
                { runs = 1000
                , distribution =
                    Test.expectDistribution
                        [ ( Test.Distribution.moreThanZero, "depth 0", \m -> MazeMakerSupport.mazeDepth m == 0 )
                        , ( Test.Distribution.moreThanZero, "depth 1", \m -> MazeMakerSupport.mazeDepth m == 1 )
                        , ( Test.Distribution.moreThanZero, "depth 2", \m -> MazeMakerSupport.mazeDepth m == 2 )
                        , ( Test.Distribution.moreThanZero, "depth 3", \m -> MazeMakerSupport.mazeDepth m == 3 )
                        ]
                }
                (Fuzz.fromGenerator MazeMaker.maze)
                "can generates mazes of depth at least 3"
              <|
                \_ -> Expect.pass
            ]
        , describe "5"
            [ fuzz (Fuzz.fromGenerator (MazeMaker.mazeOfDepth 0))
                "mazeOfDepth 0 generates a maze of depth 0"
              <|
                \maze -> MazeMakerSupport.mazeDepth maze |> Expect.equal 0
            , fuzz (Fuzz.fromGenerator (MazeMaker.mazeOfDepth 1))
                "mazeOfDepth 1 generates a maze of depth 1"
              <|
                \maze -> MazeMakerSupport.mazeDepth maze |> Expect.equal 1
            , fuzz (Fuzz.fromGenerator (MazeMaker.mazeOfDepth 5))
                "mazeOfDepth 5 generates a maze of depth 5"
              <|
                \maze -> MazeMakerSupport.mazeDepth maze |> Expect.equal 5
            , fuzz (Fuzz.fromGenerator (MazeMaker.mazeOfDepth 1))
                "mazeOfDepth 1 generates a maze with 2 to 4 rooms or deadends"
              <|
                \maze ->
                    case maze of
                        Branch branches ->
                            if List.all (MazeMakerSupport.isBranch >> not) branches then
                                List.length branches
                                    |> Expect.all [ Expect.atLeast 2, Expect.atMost 4 ]

                            else
                                Expect.fail "There should only be deadlines and rooms on depth 1 of 2"

                        _ ->
                            Expect.fail "There should only be branches on depth 0 of 1"
            , fuzz (Fuzz.fromGenerator (MazeMaker.mazeOfDepth 2))
                "mazeOfDepth 2 generates a maze with rooms and deadends at the bottom exclusively"
              <|
                \maze ->
                    let
                        branchContainsNoBranches branch =
                            case branch of
                                Branch bottomBranches ->
                                    List.all (MazeMakerSupport.isBranch >> not) bottomBranches

                                _ ->
                                    False
                    in
                    case maze of
                        Branch branches ->
                            if List.all MazeMakerSupport.isBranch branches then
                                if List.all branchContainsNoBranches branches then
                                    Expect.pass

                                else
                                    Expect.fail "There should only be deadends and rooms on depth 2 of 2"

                            else
                                Expect.fail "There should only be branches on depth 1 of 2"

                        _ ->
                            Expect.fail "There should only be branches on depth 0 of 2"
            ]
        ]
