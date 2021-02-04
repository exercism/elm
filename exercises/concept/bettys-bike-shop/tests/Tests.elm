module Tests exposing (tests)

import BettysBikeShop exposing (formatPrice)
import Expect
import Fuzz
import String
import Test exposing (..)


tests : Test
tests =
    describe "BettysBikeShop"
        [ fuzz positiveInt "price in integer pence should be converted to a string in pounds" <|
            \priceInPence ->
                formatPrice priceInPence
                    |> Expect.equal ("£" ++ String.fromFloat (toFloat priceInPence / 100.0))
        ]


positiveInt =
    Fuzz.intRange 0 10000
