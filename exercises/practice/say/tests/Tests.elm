module Tests exposing (tests)

import Expect
import Say exposing (SayError(..), say)
import Test exposing (..)


tests : Test
tests =
    describe "Say"
        [ test "one" <|
            \() ->
                Expect.equal (Ok "one")
                    (say 1)
        , skip <|
            test "fourteen" <|
                \() ->
                    Expect.equal (Ok "fourteen")
                        (say 14)
        , skip <|
            test "twenty" <|
                \() ->
                    Expect.equal (Ok "twenty")
                        (say 20)
        , skip <|
            test "twenty-two" <|
                \() ->
                    Expect.equal (Ok "twenty-two")
                        (say 22)
        , skip <|
            test "thirty" <|
                \() ->
                    Expect.equal (Ok "thirty")
                        (say 30)
        , skip <|
            test "ninety-nine" <|
                \() ->
                    Expect.equal (Ok "ninety-nine")
                        (say 99)
        , skip <|
            test "one hundred" <|
                \() ->
                    Expect.equal (Ok "one hundred")
                        (say 100)
        , skip <|
            test "one hundred and twenty" <|
                \() ->
                    Expect.equal (Ok "one hundred and twenty")
                        (say 120)
        , skip <|
            test "one hundred twenty-three" <|
                \() ->
                    Expect.equal (Ok "one hundred and twenty-three")
                        (say 123)
        , skip <|
            test "two hundred" <|
                \() ->
                    Expect.equal (Ok "two hundred")
                        (say 200)
        , skip <|
            test "nine hundred and ninety-nine" <|
                \() ->
                    Expect.equal (Ok "nine hundred and ninety-nine")
                        (say 999)
        , skip <|
            test "one thousand" <|
                \() ->
                    Expect.equal (Ok "one thousand")
                        (say 1000)
        , skip <|
            test "one thousand two hundred and thirty-four" <|
                \() ->
                    Expect.equal (Ok "one thousand two hundred and thirty-four")
                        (say 1234)
        , skip <|
            test "one million" <|
                \() ->
                    Expect.equal (Ok "one million")
                        (say 1000000)
        , skip <|
            test "one million and two" <|
                \() ->
                    Expect.equal (Ok "one million and two")
                        (say 1000002)
        , skip <|
            test "1002345" <|
                \() ->
                    Expect.equal (Ok "one million two thousand three hundred and forty-five")
                        (say 1002345)
        , skip <|
            test "one billion" <|
                \() ->
                    Expect.equal (Ok "one billion")
                        (say 1000000000)
        , skip <|
            test "number too large" <|
                \() ->
                    Expect.equal (Err TooLarge)
                        (say 10000000000000000)
        , skip <|
            test "negative number" <|
                \() ->
                    Expect.equal (Err Negative)
                        (say -42)
        , skip <|
            test "zero" <|
                \() ->
                    Expect.equal (Ok "zero")
                        (say 0)
        , skip <|
            test "987654321123" <|
                \() ->
                    Expect.equal
                        (Ok
                            ("nine hundred and eighty-seven billion "
                                ++ "six hundred and fifty-four million "
                                ++ "three hundred and twenty-one thousand "
                                ++ "one hundred and twenty-three"
                            )
                        )
                        (say 987654321123)
        ]
