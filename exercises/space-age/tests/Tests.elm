module Tests exposing (tests)

import Expect exposing (FloatingPointTolerance(..))
import SpaceAge exposing (Planet(..), ageOn)
import Test exposing (..)


tests : Test
tests =
    describe "SpaceAge"
        [ test "age in earth years" <|
            \() -> Expect.within (Absolute 0.01) 31.69 (ageOn Earth 1000000000.0)
        , skip <|
            test "age in mercury years" <|
                \() -> Expect.within (Absolute 0.01) 280.88 (ageOn Mercury 2134835688.0)
        , skip <|
            test "age in venus years" <|
                \() -> Expect.within (Absolute 0.01) 9.78 (ageOn Venus 189839836.0)
        , skip <|
            test "age on mars" <|
                \() -> Expect.within (Absolute 0.01) 35.88 (ageOn Mars 2129871239.0)
        , skip <|
            test "age on jupiter" <|
                \() -> Expect.within (Absolute 0.01) 2.41 (ageOn Jupiter 901876382.0)
        , skip <|
            test "age on saturn" <|
                \() -> Expect.within (Absolute 0.01) 2.15 (ageOn Saturn 2000000000.0)
        , skip <|
            test "age on uranus" <|
                \() -> Expect.within (Absolute 0.01) 0.46 (ageOn Uranus 1210123456.0)
        , skip <|
            test "age on neptune" <|
                \() -> Expect.within (Absolute 0.01) 0.35 (ageOn Neptune 1821023456.0)
        , skip <|
            test "2 earth years in earth years" <|
                \() -> Expect.within (Absolute 0.01) 2 (ageOn Earth 63072000.0)
        , skip <|
            test "2 earth years in mercury years" <|
                \() -> Expect.within (Absolute 0.01) 8.3 (ageOn Mercury 63072000.0)
        , skip <|
            test "2 earth years in venus years" <|
                \() -> Expect.within (Absolute 0.01) 3.25 (ageOn Venus 63072000.0)
        , skip <|
            test "2 earth years on mars" <|
                \() -> Expect.within (Absolute 0.01) 1.06 (ageOn Mars 63072000.0)
        , skip <|
            test "2 earth years on jupiter" <|
                \() -> Expect.within (Absolute 0.01) 0.17 (ageOn Jupiter 63072000.0)
        , skip <|
            test "2 earth years on saturn" <|
                \() -> Expect.within (Absolute 0.01) 0.07 (ageOn Saturn 63072000.0)
        , skip <|
            test "2 earth years on uranus" <|
                \() -> Expect.within (Absolute 0.01) 0.02 (ageOn Uranus 63072000.0)
        , skip <|
            test "2 earth years on neptune" <|
                \() -> Expect.within (Absolute 0.01) 0.01 (ageOn Neptune 63072000.0)
        ]
