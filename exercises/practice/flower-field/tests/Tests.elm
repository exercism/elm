module Tests exposing (tests)

import Expect
import FlowerField
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "FlowerField"
        [ -- skip <|
          test "no rows" <|
            \() ->
                FlowerField.annotate ""
                    |> Expect.equal ""
        , skip <|
            test "no flowers" <|
                \() ->
                    FlowerField.annotate """...
...
...""" |> Expect.equal """...
...
..."""
        , skip <|
            test "garden full of flowers" <|
                \() ->
                    FlowerField.annotate """***
***
***""" |> Expect.equal """***
***
***"""
        , skip <|
            test "flower surrounded by spaces" <|
                \() ->
                    FlowerField.annotate """...
.*.
...""" |> Expect.equal """111
1*1
111"""
        , skip <|
            test "space surrounded by flowers" <|
                \() ->
                    FlowerField.annotate """***
*.*
***""" |> Expect.equal """***
*8*
***"""
        , skip <|
            test "horizontal line" <|
                \() ->
                    FlowerField.annotate ".*.*."
                        |> Expect.equal "1*2*1"
        , skip <|
            test "horizontal line, flowers at edges" <|
                \() ->
                    FlowerField.annotate "*...*"
                        |> Expect.equal "*1.1*"
        , skip <|
            test "vertical line" <|
                \() ->
                    FlowerField.annotate """.
*
.
*
.""" |> Expect.equal """1
*
2
*
1"""
        , skip <|
            test "vertical line, flowers at edges" <|
                \() ->
                    FlowerField.annotate """*
.
.
.
*""" |> Expect.equal """*
1
.
1
*"""
        , skip <|
            test "cross" <|
                \() ->
                    FlowerField.annotate """..*..
..*..
*****
..*..
..*..""" |> Expect.equal """.2*2.
25*52
*****
25*52
.2*2."""
        , skip <|
            test "large garden" <|
                \() ->
                    FlowerField.annotate """.*..*.
..*...
....*.
...*.*
.*..*.
......""" |> Expect.equal """1*22*1
12*322
.123*2
112*4*
1*22*2
111111"""
        ]
