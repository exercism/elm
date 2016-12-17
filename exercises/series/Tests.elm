port module Main exposing (..)

import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import Series exposing (slices)


tests : Test
tests =
    describe "Series"
        [ test "slices of one" <|
            \() ->
                Expect.equal (Ok [ [ 0 ], [ 1 ], [ 2 ], [ 3 ], [ 4 ] ])
                    (slices 1 "01234")
        , test "slices of two" <|
            \() ->
                Expect.equal (Ok [ [ 9, 7 ], [ 7, 8 ], [ 8, 6 ], [ 6, 7 ], [ 7, 5 ], [ 5, 6 ], [ 6, 4 ] ])
                    (slices 2 "97867564")
        , test "slices of three" <|
            \() ->
                Expect.equal (Ok [ [ 9, 7, 8 ], [ 7, 8, 6 ], [ 8, 6, 7 ], [ 6, 7, 5 ], [ 7, 5, 6 ], [ 5, 6, 4 ] ])
                    (slices 3 "97867564")
        , test "slices of four" <|
            \() ->
                Expect.equal (Ok [ [ 0, 1, 2, 3 ], [ 1, 2, 3, 4 ] ])
                    (slices 4 "01234")
        , test "slices of five" <|
            \() ->
                Expect.equal (Ok [ [ 0, 1, 2, 3, 4 ] ])
                    (slices 5 "01234")
        , test "overly long slice" <|
            \() ->
                Expect.equal (Ok [])
                    (slices 4 "012")
        , test "overly short slice" <|
            \() ->
                Expect.equal (Err ("Invalid size: 0"))
                    (slices 0 "01234")
        , test "input has non numbers" <|
            \() ->
                Expect.equal (Err "could not convert string 'a' to an Int")
                    (slices 2 "0123abc")
        ]


main : TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
