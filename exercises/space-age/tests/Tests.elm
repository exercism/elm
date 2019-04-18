module Tests exposing (tests)

import Expect exposing (FloatingPointTolerance(..))
import SpaceAge exposing (Planet(..), ageOn)
import Test exposing (..)


tests : Test
tests =
    describe "SpaceAge"
        [ test "31.7 Earth years in Earth years" <|
            \() -> Expect.within (Absolute 0.01) 31.69 (ageOn Earth 1000000000.0)
        , skip <|
            test "2 Earth years in Earth years" <|
                \() -> Expect.within (Absolute 0.01) 2 (ageOn Earth 63115200.0)
        , skip <|
            test "67.6 Earth years in Mercury years" <|
                \() -> Expect.within (Absolute 0.01) 280.88 (ageOn Mercury 2134835688.0)
        , skip <|
            test "2 Earth years in Mercury years" <|
                \() -> Expect.within (Absolute 0.01) 8.3 (ageOn Mercury 63115200.0)
        , skip <|
            test "6 Earth years in Venus years" <|
                \() -> Expect.within (Absolute 0.01) 9.78 (ageOn Venus 189839836.0)
        , skip <|
            test "2 Earth years in Venus years" <|
                \() -> Expect.within (Absolute 0.01) 3.25 (ageOn Venus 63115200.0)
        , skip <|
            test "67.6 Earth years in Mars years" <|
                \() -> Expect.within (Absolute 0.01) 35.88 (ageOn Mars 2129871239.0)
        , skip <|
            test "2 Earth years in Mars years" <|
                \() -> Expect.within (Absolute 0.01) 1.06 (ageOn Mars 63115200.0)
        , skip <|
            test "28.6 Earth years in Jupiter years" <|
                \() -> Expect.within (Absolute 0.01) 2.41 (ageOn Jupiter 901876382.0)
        , skip <|
            test "2 Earth years in Jupiter years" <|
                \() -> Expect.within (Absolute 0.01) 0.17 (ageOn Jupiter 63115200.0)
        , skip <|
            test "63.5 Earth years in Saturn years" <|
                \() -> Expect.within (Absolute 0.01) 2.15 (ageOn Saturn 2000000000.0)
        , skip <|
            test "2 Earth years in saturn years" <|
                \() -> Expect.within (Absolute 0.01) 0.07 (ageOn Saturn 63115200.0)
        , skip <|
            test "38.3 Earth years in Uranus years" <|
                \() -> Expect.within (Absolute 0.01) 0.46 (ageOn Uranus 1210123456.0)
        , skip <|
            test "2 Earth years in uranus years" <|
                \() -> Expect.within (Absolute 0.01) 0.02 (ageOn Uranus 63115200.0)
        , skip <|
            test "57.7 Earth years in Neptune years" <|
                \() -> Expect.within (Absolute 0.01) 0.35 (ageOn Neptune 1821023456.0)
        , skip <|
            test "2 Earth years in Neptune years" <|
                \() -> Expect.within (Absolute 0.01) 0.01 (ageOn Neptune 63115200.0)
        ]
