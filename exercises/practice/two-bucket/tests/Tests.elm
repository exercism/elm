module Tests exposing (tests)

import Expect
import Test exposing (Test, describe, skip, test)
import TwoBucket exposing (BucketNumber(..))


tests : Test
tests =
    describe "TwoBucket"
        [ -- skip <|
          test "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket one" <|
            \() ->
                TwoBucket.measure 3 5 1 One
                    |> Expect.equal (Just { moves = 4, bucketOne = 1, bucketTwo = 5 })
        , skip <|
            test "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket two" <|
                \() ->
                    TwoBucket.measure 3 5 1 Two
                        |> Expect.equal (Just { moves = 8, bucketOne = 3, bucketTwo = 1 })
        , skip <|
            test "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket one" <|
                \() ->
                    TwoBucket.measure 7 11 2 One
                        |> Expect.equal (Just { moves = 14, bucketOne = 2, bucketTwo = 11 })
        , skip <|
            test "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket two" <|
                \() ->
                    TwoBucket.measure 7 11 2 Two
                        |> Expect.equal (Just { moves = 18, bucketOne = 7, bucketTwo = 2 })
        , skip <|
            test "Measure one step using bucket one of size 1 and bucket two of size 3 - start with bucket two" <|
                \() ->
                    TwoBucket.measure 1 3 3 Two
                        |> Expect.equal (Just { moves = 1, bucketOne = 0, bucketTwo = 3 })
        , skip <|
            test "Measure using bucket one of size 2 and bucket two of size 3 - start with bucket one and end with bucket two" <|
                \() ->
                    TwoBucket.measure 2 3 3 One
                        |> Expect.equal (Just { moves = 2, bucketOne = 2, bucketTwo = 3 })
        , skip <|
            test "Not possible to reach the goal" <|
                \() ->
                    TwoBucket.measure 6 15 5 One
                        |> Expect.equal Nothing
        , skip <|
            test "With the same buckets but a different goal, then it is possible" <|
                \() ->
                    TwoBucket.measure 6 15 9 One
                        |> Expect.equal (Just { moves = 10, bucketOne = 0, bucketTwo = 9 })
        , skip <|
            test "Goal larger than both buckets is impossible" <|
                \() ->
                    TwoBucket.measure 5 7 8 One
                        |> Expect.equal Nothing
        ]
