module Etl exposing (transform)

import Dict exposing (Dict)


transform : Dict Int (List String) -> Dict String Int
transform input =
    Dict.foldl addLetters Dict.empty input


addLetters : Int -> List String -> Dict String Int -> Dict String Int
addLetters score letters output =
    letters
        |> List.map String.toLower
        |> List.foldl (\letter output -> Dict.insert letter score output) output
