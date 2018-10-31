module Tests exposing (tests)

import Expect
import String
import Test exposing (..)
import TwoFer exposing (twoFer)


tests : Test
tests =
    describe "Two-fer"
        [ test "No name given" <|
            \() ->
                Expect.equal "One for you, one for me." (twoFer Nothing)
        , skip <|
            test "A name given" <|
                \() ->
                    Expect.equal "One for Alice, one for me." (twoFer (Just "Alice"))
        , skip <|
            test "Another name given" <|
                \() ->
                    Expect.equal "One for Bob, one for me." (twoFer (Just "Bob"))
        ]
