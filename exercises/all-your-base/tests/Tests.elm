module Tests exposing (tests)

import AllYourBase exposing (rebase)
import Expect
import Test exposing (..)


tests : Test
tests =
    describe "all-your-base"
        [ test "single bit one to decimal" <|
            \() -> Expect.equal (Just [ 1 ]) (rebase 2 [ 1 ] 10)
        , skip <|
            test "binary to single decimal" <|
                \() -> Expect.equal (Just [ 5 ]) (rebase 2 [ 1, 0, 1 ] 10)
        , skip <|
            test "single decimal to binary" <|
                \() -> Expect.equal (Just [ 1, 0, 1 ]) (rebase 10 [ 5 ] 2)
        , skip <|
            test "binary to multiple decimal" <|
                \() -> Expect.equal (Just [ 4, 2 ]) (rebase 2 [ 1, 0, 1, 0, 1, 0 ] 10)
        , skip <|
            test "decimal to binary" <|
                \() -> Expect.equal (Just [ 1, 0, 1, 0, 1, 0 ]) (rebase 10 [ 4, 2 ] 2)
        , skip <|
            test "trinary to hexadecimal" <|
                \() -> Expect.equal (Just [ 2, 10 ]) (rebase 3 [ 1, 1, 2, 0 ] 16)
        , skip <|
            test "hexadecimal to trinary" <|
                \() -> Expect.equal (Just [ 1, 1, 2, 0 ]) (rebase 16 [ 2, 10 ] 3)
        , skip <|
            test "15-bit integer" <|
                \() -> Expect.equal (Just [ 6, 10, 45 ]) (rebase 97 [ 3, 46, 60 ] 73)
        , skip <|
            test "empty list" <|
                \() -> Expect.equal Nothing (rebase 2 [] 10)
        , skip <|
            test "single zero" <|
                \() -> Expect.equal Nothing (rebase 10 [ 0 ] 2)
        , skip <|
            test "multiple zeros" <|
                \() -> Expect.equal Nothing (rebase 10 [ 0, 0, 0 ] 2)
        , skip <|
            test "leading zeros" <|
                \() -> Expect.equal (Just [ 4, 2 ]) (rebase 7 [ 0, 6, 0 ] 10)
        , skip <|
            test "first base is one" <|
                \() -> Expect.equal Nothing (rebase 1 [] 10)
        , skip <|
            test "first base is zero" <|
                \() -> Expect.equal Nothing (rebase 0 [] 10)
        , skip <|
            test "first base is negative" <|
                \() -> Expect.equal Nothing (rebase -1 [] 10)
        , skip <|
            test "negative digit" <|
                \() -> Expect.equal Nothing (rebase 2 [ 1, -1, 1, 0, 1, 0 ] 10)
        , skip <|
            test "invalid positive digit" <|
                \() -> Expect.equal Nothing (rebase 2 [ 1, 2, 1, 0, 1, 0 ] 10)
        , skip <|
            test "second base is one" <|
                \() -> Expect.equal Nothing (rebase 10 [] 1)
        , skip <|
            test "second base is zero" <|
                \() -> Expect.equal Nothing (rebase 10 [ 1 ] 0)
        , skip <|
            test "second base is negative" <|
                \() -> Expect.equal Nothing (rebase 10 [ 1 ] -1)
        , skip <|
            test "both bases are negative" <|
                \() -> Expect.equal Nothing (rebase -1 [ 1 ] -1)
        ]
