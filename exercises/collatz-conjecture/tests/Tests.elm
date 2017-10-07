module Tests exposing (..)

import Test exposing (..)
import Expect
import CollatzConjecture exposing (collatz)


tests : Test
tests =
    describe "CollatzConjecture tests"
        [ test "zero steps for one" <|
            \() ->
                Expect.equal (Ok 0) (collatz 1)

        -- Once you get the first test passing, remove the
        -- `skip <|` (just leave the comma) on the next
        -- lines to continue!

        , skip <|
            test "divide if even" <|
            \() ->
                Expect.equal (Ok 4) (collatz 16)
        , skip <|
            test "even and odd step" <|
            \() ->
                Expect.equal (Ok 9) (collatz 12)
        , skip <|
            test "Large number of even and odd step" <|
            \() ->
                Expect.equal (Ok 152) (collatz 1000000)
        , skip <|
            test "zero is an error" <|
            \() ->
                Expect.equal (Err "Only positive numbers are allowed") (collatz 0)
        , skip <|
            test "negative values is an error" <|
            \() ->
                Expect.equal (Err "Only positive numbers are allowed") (collatz -15)
        ]
