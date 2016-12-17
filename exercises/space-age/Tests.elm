port module Main exposing (..)

import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import SpaceAge exposing (Planet(..), ageOn)


tests : Test
tests =
    describe "SpaceAge"
        [ test "age in earth years" <|
            \() -> Expect.equal 32 (round (ageOn Earth 1000000000))
        , test "age in mercury years" <|
            \() -> Expect.equal 281 (round (ageOn Mercury 2134835688))
        , test "age in venus years" <|
            \() -> Expect.equal 10 (round (ageOn Venus 189839836))
        , test "age on mars" <|
            \() -> Expect.equal 39 (round (ageOn Mars 2329871239))
        , test "age on jupiter" <|
            \() -> Expect.equal 2 (round (ageOn Jupiter 901876382))
        , test "age on saturn" <|
            \() -> Expect.equal 3 (round (ageOn Saturn 3000000000))
        , test "age on uranus" <|
            \() -> Expect.equal 1 (round (ageOn Uranus 3210123456))
        , test "age on neptune" <|
            \() -> Expect.equal 2 (round (ageOn Neptune 8210123456))
        ]


main : TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
