module Tests exposing (tests)

import Expect
import Minesweeper
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "Minesweeper"
        [ -- skip <|
          test "no rows" <|
            \() ->
                Minesweeper.annotate ""
                    |> Expect.equal ""
        , skip <|
            test "no mines" <|
                \() ->
                    Minesweeper.annotate """...
...
...""" |> Expect.equal """...
...
..."""
        , skip <|
            test "minefield with only mines" <|
                \() ->
                    Minesweeper.annotate """***
***
***""" |> Expect.equal """***
***
***"""
        , skip <|
            test "mine surrounded by spaces" <|
                \() ->
                    Minesweeper.annotate """...
.*.
...""" |> Expect.equal """111
1*1
111"""
        , skip <|
            test "space surrounded by mines" <|
                \() ->
                    Minesweeper.annotate """***
*.*
***""" |> Expect.equal """***
*8*
***"""
        , skip <|
            test "horizontal line" <|
                \() ->
                    Minesweeper.annotate ".*.*."
                        |> Expect.equal "1*2*1"
        , skip <|
            test "horizontal line, mines at edges" <|
                \() ->
                    Minesweeper.annotate "*...*"
                        |> Expect.equal "*1.1*"
        , skip <|
            test "vertical line" <|
                \() ->
                    Minesweeper.annotate """.
*
.
*
.""" |> Expect.equal """1
*
2
*
1"""
        , skip <|
            test "vertical line, mines at edges" <|
                \() ->
                    Minesweeper.annotate """*
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
                    Minesweeper.annotate """..*..
..*..
*****
..*..
..*..""" |> Expect.equal """.2*2.
25*52
*****
25*52
.2*2."""
        , skip <|
            test "large minefield" <|
                \() ->
                    Minesweeper.annotate """.*..*.
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
