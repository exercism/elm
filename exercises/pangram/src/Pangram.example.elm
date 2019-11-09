module Pangram exposing (isPangram)

import String exposing (contains, fromChar, toLower)


isPangram : String -> Bool
isPangram sentence =
    let
        normalized =
            toLower sentence
    in
    String.all (\c -> contains (fromChar c) normalized) alphabet


alphabet : String
alphabet =
    "abcdefghijklmnopqrstuvwxyz"
