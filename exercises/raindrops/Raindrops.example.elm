module Raindrops exposing (raindrops)

import String


raindrops : Int -> String
raindrops number =
    let
        drops =
            [ if modBy 3 number == 0 then
                "Pling"

              else
                ""
            , if modBy 5 number == 0 then
                "Plang"

              else
                ""
            , if modBy 7 number == 0 then
                "Plong"

              else
                ""
            ]

        result =
            String.join "" drops
    in
    if result == "" then
        String.fromInt number

    else
        result
