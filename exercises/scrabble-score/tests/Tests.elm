module Tests exposing (..)

import Test exposing (..)
import Expect
import ScrabbleScore exposing (scoreWord)


tests : Test
tests =
    describe "Grains"
        [ test "lowercase letter" <|
            \() -> Expect.equal 1 (scoreWord "a")
        , skip <|
            test "uppercase letter" <|
                \() -> Expect.equal 1 (scoreWord "A")
        , skip <|
            test "valuable letter" <|
                \() -> Expect.equal 4 (scoreWord "f")
        , skip <|
            test "short word" <|
                \() -> Expect.equal 2 (scoreWord "at")
        , skip <|
            test "short, valuable word" <|
                \() -> Expect.equal 12 (scoreWord "zoo")
        , skip <|
            test "medium word" <|
                \() -> Expect.equal 6 (scoreWord "street")
        , skip <|
            test "medium, valuable word" <|
                \() -> Expect.equal 22 (scoreWord "quirky")
        , skip <|
            test "long, mixed-case word" <|
                \() -> Expect.equal 41 (scoreWord "OxyphenButazone")
        , skip <|
            test "english-like word" <|
                \() -> Expect.equal 8 (scoreWord "pinata")
        , skip <|
            test "non-english letter is not scored" <|
                \() -> Expect.equal 7 (scoreWord "piñata")
        , skip <|
            test "empty input" <|
                \() -> Expect.equal 0 (scoreWord "")
        ]
