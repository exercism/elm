module Tests exposing (tests)

import Array
import BinarySearch exposing (find)
import Expect
import Fuzz exposing (Fuzzer)
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "binarySearch"
        [ test "finds a value in an array with one element" <|
            \() ->
                Array.fromList [ 6 ]
                    |> find 6
                    |> Expect.equal 0
        , skip <|
            test "finds a value in the middle of an array" <|
                \() ->
                    Array.fromList [ 1, 3, 4, 6, 8, 9, 11 ]
                        |> find 6
                        |> Expect.equal 3
        , skip <|
            test "finds a value at the beginning of an array" <|
                \() ->
                    Array.fromList [ 1, 3, 4, 6, 8, 9, 11 ]
                        |> find 1
                        |> Expect.equal 0
        , skip <|
            test "finds a value in an array of odd length" <|
                \() ->
                    Array.fromList [ 1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 634 ]
                        |> find 144
                        |> Expect.equal 9
        , skip <|
            test "finds a value in an array of even length" <|
                \() ->
                    Array.fromList [ 1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377 ]
                        |> find 21
                        |> Expect.equal 5
        , skip <|
            test "identifies that a value is not included in the array" <|
                \() ->
                    Array.fromList [ 1, 3, 4, 6, 8, 9, 11 ]
                        |> find 7
                        |> Expect.equal -1
        , skip <|
            test "a value smaller than the array's smallest value is not included" <|
                \() ->
                    Array.fromList [ 1, 3, 4, 6, 8, 9, 11 ]
                        |> find 0
                        |> Expect.equal -1
        , skip <|
            test "a value larger than the array's largest value is not included" <|
                \() ->
                    Array.fromList [ 1, 3, 4, 6, 8, 9, 11 ]
                        |> find 13
                        |> Expect.equal -1
        , skip <|
            test "nothing is included in an empty array" <|
                \() ->
                    Array.empty
                        |> find 1
                        |> Expect.equal -1
        ]
