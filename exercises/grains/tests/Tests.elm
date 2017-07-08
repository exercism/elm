module Tests exposing (..)

import Expect
import Grains exposing (square)
import Json.Encode exposing (Value)
import Test exposing (..)


tests : Test
tests =
    describe "Grains"
        [ describe "square"
            [ test "of 1" <|
                \() -> Expect.equal (Just 1) (square 1)
            , skip <|
                test "of 2" <|
                    \() -> Expect.equal (Just 2) (square 2)
            , skip <|
                test "of 3" <|
                    \() -> Expect.equal (Just 4) (square 3)
            , skip <|
                test "of 4" <|
                    \() -> Expect.equal (Just 8) (square 4)
            , skip <|
                test "of 16" <|
                    \() -> Expect.equal (Just 32768) (square 16)
            , skip <|
                test "of 32" <|
                    \() -> Expect.equal (Just 2147483648) (square 32)
            , skip <|
                test "square 0 raises an exception" <|
                    \() -> Expect.equal Nothing (square 0)
            , skip <|
                test "negative square raises an exception" <|
                    \() -> Expect.equal Nothing (square -1)

            {-
               Where are the bigger test values?!? Because Javascript's numbers
               can't represent values higher than `Number.MAX_SAFE_INTEGER`
               (i.e. 9007199254740991), we chose to exclude these final values
               to avoid the weirdness. A bit more information can be found
               here: https://github.com/elm-lang/elm-compiler/issues/1246
            -}
            ]
        ]
