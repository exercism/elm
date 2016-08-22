port module Main exposing (..)

import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import Raindrops exposing (raindrops)


tests : Test
tests =
    describe "Raindrops"
        [ test "1" <|
            \() -> Expect.equal "1" (raindrops 1)
        , test "3" <|
            \() -> Expect.equal "Pling" (raindrops 3)
        , test "5" <|
            \() -> Expect.equal "Plang" (raindrops 5)
        , test "7" <|
            \() -> Expect.equal "Plong" (raindrops 7)
        , test "6" <|
            \() -> Expect.equal "Pling" (raindrops 6)
        , test "9" <|
            \() -> Expect.equal "Pling" (raindrops 9)
        , test "10" <|
            \() -> Expect.equal "Plang" (raindrops 10)
        , test "14" <|
            \() -> Expect.equal "Plong" (raindrops 14)
        , test "15" <|
            \() -> Expect.equal "PlingPlang" (raindrops 15)
        , test "21" <|
            \() -> Expect.equal "PlingPlong" (raindrops 21)
        , test "25" <|
            \() -> Expect.equal "Plang" (raindrops 25)
        , test "35" <|
            \() -> Expect.equal "PlangPlong" (raindrops 35)
        , test "49" <|
            \() -> Expect.equal "Plong" (raindrops 49)
        , test "52" <|
            \() -> Expect.equal "52" (raindrops 52)
        , test "105" <|
            \() -> Expect.equal "PlingPlangPlong" (raindrops 105)
        ]


main : Program Value
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
