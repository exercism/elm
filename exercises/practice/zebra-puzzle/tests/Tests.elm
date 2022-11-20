module Tests exposing (tests)

import Expect
import Test exposing (Test, describe, skip, test)
import ZebraPuzzle


tests : Test
tests =
    describe "ZebraPuzzle"
        [ test "resident who drinks water" <|
            \() ->
                ZebraPuzzle.drinksWater
                    |> Expect.equal (Just ZebraPuzzle.Norwegian)
        , skip <|
            test "resident who owns zebra" <|
                \() ->
                    ZebraPuzzle.ownsZebra
                        |> Expect.equal (Just ZebraPuzzle.Japanese)
        ]
