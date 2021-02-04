module BettysBikeShop exposing (formatPrice)

import String


formatPrice : Int -> String
formatPrice priceInPence =
    "£" ++ String.fromFloat (toFloat priceInPence / 100.0)
