module Anagram exposing (..)

import String exposing (toList, toLower)


detect : String -> List String -> List String
detect word candidates =
    let
        original =
            toLower word

        ref =
            normalize word
    in
    List.filter (\w -> normalize w == ref && toLower w /= original) candidates


normalize : String -> List Char
normalize word =
    word |> toLower |> toList |> List.sort
