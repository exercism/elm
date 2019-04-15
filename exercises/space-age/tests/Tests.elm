module Tests exposing (tests)

import Expect
import SpaceAge exposing (Planet(..), ageOn)
import Test exposing (..)


tests : Test
tests =
    describe "SpaceAge"
        [ test "age in earth years" <|
            \() -> Expect.equal 32 (round (ageOn Earth 1000000000.0))
        , skip <|
            test "age in mercury years" <|
                \() -> Expect.equal 281 (round (ageOn Mercury 2134835688.0))
        , skip <|
            test "age in venus years" <|
                \() -> Expect.equal 10 (round (ageOn Venus 189839836.0))
        , skip <|
            test "age on mars" <|
                \() -> Expect.equal 39 (round (ageOn Mars 2329871239.0))
        , skip <|
            test "age on jupiter" <|
                \() -> Expect.equal 2 (round (ageOn Jupiter 901876382.0))
        , skip <|
            test "age on saturn" <|
                \() -> Expect.equal 3 (round (ageOn Saturn 3000000000.0))
        , skip <|
            test "age on uranus" <|
                \() -> Expect.equal 1 (round (ageOn Uranus 3210123456.0))
        , skip <|
            test "age on neptune" <|
                \() -> Expect.equal 2 (round (ageOn Neptune 8210123456.0))
        , skip <|
            test "2 earth years in earth years" <|
                \() -> Expect.equal 2 (round (ageOn Earth 63072000.0))
        , skip <|
            test "2 earth years in mercury years" <|
                \() -> Expect.equal 8 (round (ageOn Mercury 63072000.0))
        , skip <|
            test "2 earth years in venus years" <|
                \() -> Expect.equal 3 (round (ageOn Venus 63072000.0))
        , skip <|
            test "2 earth years on mars" <|
                \() -> Expect.equal 1 (round (ageOn Mars 63072000.0))
        , skip <|
            test "2 earth years on jupiter" <|
                \() -> Expect.equal 0 (round (ageOn Jupiter 63072000.0))
        , skip <|
            test "2 earth years on saturn" <|
                \() -> Expect.equal 0 (round (ageOn Saturn 63072000.0))
        , skip <|
            test "2 earth years on uranus" <|
                \() -> Expect.equal 0 (round (ageOn Uranus 63072000.0))
        , skip <|
            test "2 earth years on neptune" <|
                \() -> Expect.equal 0 (round (ageOn Neptune 63072000.0))
        , skip <|
            test "128 earth years in earth years" <|
                \() -> Expect.equal 129 (round (ageOn Earth 4036608000.0))
        , skip <|
            test "128 earth years in mercury years" <|
                \() -> Expect.equal 531 (round (ageOn Mercury 4036608000.0))
        , skip <|
            test "128 earth years in venus years" <|
                \() -> Expect.equal 213 (round (ageOn Venus 4036608000.0))
        , skip <|
            test "128 earth years on mars" <|
                \() -> Expect.equal 68 (round (ageOn Mars 4036608000.0))
        , skip <|
            test "128 earth years on jupiter" <|
                \() -> Expect.equal 9 (round (ageOn Jupiter 4036608000.0))
        , skip <|
            test "128 earth years on saturn" <|
                \() -> Expect.equal 4 (round (ageOn Saturn 4036608000.0))
        , skip <|
            test "128 earth years on uranus" <|
                \() -> Expect.equal 1 (round (ageOn Uranus 4036608000.0))
        , skip <|
            test "128 earth years on neptune" <|
                \() -> Expect.equal 1 (round (ageOn Neptune 4036608000.0))
        ]
