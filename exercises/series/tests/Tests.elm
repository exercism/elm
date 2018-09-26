module Tests exposing (tests)

import Expect
import Series exposing (slices)
import Test exposing (..)


tests : Test
tests =
    describe "Series"
        [ test "slices of one from one" <|
            \() ->
                Expect.equal (Ok [ [ 1 ] ])
                    (slices 1 "1")
        , skip <|
            test "slices of one from two" <|
                \() ->
                    Expect.equal (Ok [ [ 1 ], [ 2 ] ])
                        (slices 1 "12")
        , skip <|
            test "slices of two" <|
                \() ->
                    Expect.equal (Ok [ [ 3, 5 ] ])
                        (slices 2 "35")
        , skip <|
            test "slices of two overlap" <|
                \() ->
                    Expect.equal (Ok [ [ 9, 1 ], [ 1, 4 ], [ 4, 2 ] ])
                        (slices 2 "9142")
        , skip <|
            test "slices can include duplicates" <|
                \() ->
                    Expect.equal (Ok [ [ 7, 7, 7 ], [ 7, 7, 7 ], [ 7, 7, 7 ], [ 7, 7, 7 ] ])
                        (slices 3 "777777")
        , skip <|
            test "slices of a long series" <|
                \() ->
                    Expect.equal (Ok [ [ 9, 1, 8, 4, 9 ], [ 1, 8, 4, 9, 3 ], [ 8, 4, 9, 3, 9 ], [ 4, 9, 3, 9, 0 ], [ 9, 3, 9, 0, 4 ], [ 3, 9, 0, 4, 2 ], [ 9, 0, 4, 2, 4 ], [ 0, 4, 2, 4, 3 ] ])
                        (slices 5 "918493904243")
        , skip <|
            test "slice length is too large" <|
                \() ->
                    Expect.equal (Err "slice length cannot be greater than series length")
                        (slices 6 "12345")
        , skip <|
            test "slice length cannot be zero" <|
                \() ->
                    Expect.equal (Err "slice length cannot be zero")
                        (slices 0 "12345")
        , skip <|
            test "slice length cannot be negative" <|
                \() ->
                    Expect.equal (Err "slice length cannot be negative")
                        (slices -1 "123")
        , skip <|
            test "empty series is invalid" <|
                \() ->
                    Expect.equal (Err "series cannot be empty")
                        (slices 1 "")
        ]
