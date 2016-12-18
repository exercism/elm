port module Main exposing (..)

import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import Say exposing (say, SayError(Negative, TooLarge))


tests : Test
tests =
    describe "Series"
        [ test "one" <|
            \() ->
                Expect.equal (Ok "one")
                    (say 1)
        , test "fourteen" <|
            \() ->
                Expect.equal (Ok "fourteen")
                    (say 14)
        , test "twenty" <|
            \() ->
                Expect.equal (Ok "twenty")
                    (say 20)
        , test "twenty-two" <|
            \() ->
                Expect.equal (Ok "twenty-two")
                    (say 22)
        , test "one hundred" <|
            \() ->
                Expect.equal (Ok "one hundred")
                    (say 100)
        , test "one hundred twenty" <|
            \() ->
                Expect.equal (Ok "one hundred and twenty")
                    (say 120)
        , test "one hundred twenty-three" <|
            \() ->
                Expect.equal (Ok "one hundred and twenty-three")
                    (say 123)
        , test "one thousand" <|
            \() ->
                Expect.equal (Ok "one thousand")
                    (say 1000)
        , test "one thousand two hundred thirty-four" <|
            \() ->
                Expect.equal (Ok "one thousand two hundred and thirty-four")
                    (say 1234)
        , test "one million" <|
            \() ->
                Expect.equal (Ok "one million")
                    (say 1000000)
        , test "one million two" <|
            \() ->
                Expect.equal (Ok "one million and two")
                    (say 1000002)
        , test "1002345" <|
            \() ->
                Expect.equal (Ok "one million two thousand three hundred and forty-five")
                    (say 1002345)
        , test "one billion" <|
            \() ->
                Expect.equal (Ok "one billion")
                    (say 1000000000)
        , test "number too large" <|
            \() ->
                Expect.equal (Err TooLarge)
                    (say 10000000000000000)
        , test "negative number" <|
            \() ->
                Expect.equal (Err Negative)
                    (say -42)
        , test "zero" <|
            \() ->
                Expect.equal (Ok "zero")
                    (say 0)
        , test "987654321123" <|
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


main : TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
