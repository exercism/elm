module Tests exposing (tests)

import Expect
import PopCount exposing (eggCount)
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "Pop Count"
        [ test "0 eggs" <|
            \() -> Expect.equal 0 (eggCount 0)
        , skip <|
            test "1 egg" <|
                \() -> Expect.equal 1 (eggCount 16)
        , skip <|
            test "4 eggs" <|
                \() -> Expect.equal 4 (eggCount 89)
        , skip <|
            test "13 eggs" <|
                \() -> Expect.equal 13 (eggCount 2000000000)
        ]
