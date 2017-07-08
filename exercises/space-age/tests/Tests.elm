module Tests exposing (..)

import Test exposing (..)
import Expect
import SpaceAge exposing (Planet(..), ageOn)


tests : Test
tests =
    describe "SpaceAge"
        [ test "age in earth years" <|
            \() -> Expect.equal 32 (round (ageOn Earth 1000000000))
        , skip <|
            test "age in mercury years" <|
                \() -> Expect.equal 281 (round (ageOn Mercury 2134835688))
        , skip <|
            test "age in venus years" <|
                \() -> Expect.equal 10 (round (ageOn Venus 189839836))
        , skip <|
            test "age on mars" <|
                \() -> Expect.equal 39 (round (ageOn Mars 2329871239))
        , skip <|
            test "age on jupiter" <|
                \() -> Expect.equal 2 (round (ageOn Jupiter 901876382))
        , skip <|
            test "age on saturn" <|
                \() -> Expect.equal 3 (round (ageOn Saturn 3000000000))
        , skip <|
            test "age on uranus" <|
                \() -> Expect.equal 1 (round (ageOn Uranus 3210123456))
        , skip <|
            test "age on neptune" <|
                \() -> Expect.equal 2 (round (ageOn Neptune 8210123456))
        ]
