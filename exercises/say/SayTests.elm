module Main exposing (..)

import ElmTest exposing (..)
import Say exposing (say, SayError(Negative, TooLarge))


tests : Test
tests =
    suite "Series"
        [ test "one"
            (assertEqual (Ok "one")
                (say 1)
            )
        , test "fourteen"
            (assertEqual (Ok "fourteen")
                (say 14)
            )
        , test "twenty"
            (assertEqual (Ok "twenty")
                (say 20)
            )
        , test "twenty-two"
            (assertEqual (Ok "twenty-two")
                (say 22)
            )
        , test "one hundred"
            (assertEqual (Ok "one hundred")
                (say 100)
            )
        , test "one hundred twenty"
            (assertEqual (Ok "one hundred and twenty")
                (say 120)
            )
        , test "one hundred twenty-three"
            (assertEqual (Ok "one hundred and twenty-three")
                (say 123)
            )
        , test "one thousand"
            (assertEqual (Ok "one thousand")
                (say 1000)
            )
        , test "one thousand two hundred thirty-four"
            (assertEqual (Ok "one thousand two hundred and thirty-four")
                (say 1234)
            )
        , test "one million"
            (assertEqual (Ok "one million")
                (say 1000000)
            )
        , test "one million two"
            (assertEqual (Ok "one million and two")
                (say 1000002)
            )
        , test "1002345"
            (assertEqual (Ok "one million two thousand three hundred and forty-five")
                (say 1002345)
            )
        , test "one billion"
            (assertEqual (Ok "one billion")
                (say 1000000000)
            )
        , test "number too large"
            (assertEqual (Err TooLarge)
                (say 10000000000000000)
            )
        , test "negative number"
            (assertEqual (Err Negative)
                (say -42)
            )
        , test "zero"
            (assertEqual (Ok "zero")
                (say 0)
            )
        , test "987654321123"
            (assertEqual
                (Ok
                    ("nine hundred and eighty-seven billion "
                        ++ "six hundred and fifty-four million "
                        ++ "three hundred and twenty-one thousand "
                        ++ "one hundred and twenty-three"
                    )
                )
                (say 987654321123)
            )
        ]


main : Program Never
main =
    runSuite tests
