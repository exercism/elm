module BettysBikeShop exposing (penceToPounds, poundsToString)

import String


penceToPounds : Int -> Float
penceToPounds pence =
    toFloat pence / 100.0


poundsToString : Float -> String
poundsToString pounds =
    "£" ++ String.fromFloat pounds
