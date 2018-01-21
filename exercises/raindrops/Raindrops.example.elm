module Raindrops exposing (..)

import String


raindrops : Int -> String
raindrops number =
    let
        drops =
            [ if number % 3 == 0 then
                "Pling"
              else
                ""
            , if number % 5 == 0 then
                "Plang"
              else
                ""
            , if number % 7 == 0 then
                "Plong"
              else
                ""
            ]

        result =
            String.join "" drops
    in
    if result == "" then
        toString number
    else
        result
