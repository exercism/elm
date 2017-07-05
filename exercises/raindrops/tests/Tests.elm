module Tests exposing (..)

import Test exposing (..)
import Expect
import Raindrops exposing (raindrops)


tests : Test
tests =
    describe "Raindrops"
        [ test "1" <|
            \() -> Expect.equal "1" (raindrops 1)
        , skip <|
            test "3" <|
                \() -> Expect.equal "Pling" (raindrops 3)
        , skip <|
            test "5" <|
                \() -> Expect.equal "Plang" (raindrops 5)
        , skip <|
            test "7" <|
                \() -> Expect.equal "Plong" (raindrops 7)
        , skip <|
            test "6" <|
                \() -> Expect.equal "Pling" (raindrops 6)
        , skip <|
            test "9" <|
                \() -> Expect.equal "Pling" (raindrops 9)
        , skip <|
            test "10" <|
                \() -> Expect.equal "Plang" (raindrops 10)
        , skip <|
            test "14" <|
                \() -> Expect.equal "Plong" (raindrops 14)
        , skip <|
            test "15" <|
                \() -> Expect.equal "PlingPlang" (raindrops 15)
        , skip <|
            test "21" <|
                \() -> Expect.equal "PlingPlong" (raindrops 21)
        , skip <|
            test "25" <|
                \() -> Expect.equal "Plang" (raindrops 25)
        , skip <|
            test "35" <|
                \() -> Expect.equal "PlangPlong" (raindrops 35)
        , skip <|
            test "49" <|
                \() -> Expect.equal "Plong" (raindrops 49)
        , skip <|
            test "52" <|
                \() -> Expect.equal "52" (raindrops 52)
        , skip <|
            test "105" <|
                \() -> Expect.equal "PlingPlangPlong" (raindrops 105)
        ]
