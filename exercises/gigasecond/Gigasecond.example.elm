module Gigasecond exposing (add)

import Time


add : Time.Posix -> Time.Posix
add timestamp =
    timestamp
        |> Time.posixToMillis
        |> (+) gigasecond
        |> Time.millisToPosix


gigasecond : Int
gigasecond =
    10 ^ 12
