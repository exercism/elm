module Tests exposing (tests)

import BettysBikeShop exposing (penceToPounds, poundsToString)
import Expect exposing (FloatingPointTolerance(..))
import Test exposing (..)


tests : Test
tests =
    describe "BettysBikeShop"
        [ describe "1"
            [ test "penceToPounds has been imported" <|
                \_ ->
                    Expect.pass
            ]
        , describe "2"
            [ test "599 pence should be 5.99 pounds" <|
                \_ ->
                    penceToPounds (truncate 599)
                        |> Expect.within (Absolute 0.001) 5.99
            , test "33 pence should be 0.33 pounds" <|
                \_ ->
                    penceToPounds (truncate 33)
                        |> Expect.within (Absolute 0.001) 0.33
            ]
        , describe "3"
            [ test "5.99 pounds should be formatted as £5.99" <|
                \_ ->
                    poundsToString 5.99
                        |> Expect.equal "£5.99"
            , test "0.33 pounds should be formatted as £0.33" <|
                \_ ->
                    poundsToString 0.33
                        |> Expect.equal "£0.33"
            ]
        ]
