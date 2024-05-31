module Tests exposing (tests)

import Expect
import SecretHandshake exposing (Command(..))
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "SecretHandshake"
        [ -- skip <|
          test "wink for 1" <|
            \() ->
                SecretHandshake.commands 1
                    |> Expect.equal [ Wink ]
        , skip <|
            test "double blink for 10" <|
                \() ->
                    SecretHandshake.commands 2
                        |> Expect.equal [ DoubleBlink ]
        , skip <|
            test "close your eyes for 100" <|
                \() ->
                    SecretHandshake.commands 4
                        |> Expect.equal [ CloseYourEyes ]
        , skip <|
            test "jump for 1000" <|
                \() ->
                    SecretHandshake.commands 8
                        |> Expect.equal [ Jump ]
        , skip <|
            test "combine two actions" <|
                \() ->
                    SecretHandshake.commands 3
                        |> Expect.equal [ Wink, DoubleBlink ]
        , skip <|
            test "reverse two actions" <|
                \() ->
                    SecretHandshake.commands 19
                        |> Expect.equal [ DoubleBlink, Wink ]
        , skip <|
            test "reversing one action gives the same action" <|
                \() ->
                    SecretHandshake.commands 24
                        |> Expect.equal [ Jump ]
        , skip <|
            test "reversing no actions still gives no actions" <|
                \() ->
                    SecretHandshake.commands 16
                        |> Expect.equal []
        , skip <|
            test "all possible actions" <|
                \() ->
                    SecretHandshake.commands 15
                        |> Expect.equal [ Wink, DoubleBlink, CloseYourEyes, Jump ]
        , skip <|
            test "reverse all possible actions" <|
                \() ->
                    SecretHandshake.commands 31
                        |> Expect.equal [ Jump, CloseYourEyes, DoubleBlink, Wink ]
        , skip <|
            test "do nothing for zero" <|
                \() ->
                    SecretHandshake.commands 0
                        |> Expect.equal []
        ]
