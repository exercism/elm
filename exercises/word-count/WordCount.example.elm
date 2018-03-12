module WordCount exposing (wordCount)

import Dict exposing (Dict)
import Regex
import String


wordCount : String -> Dict String Int
wordCount sentence =
    sentence
        |> String.toLower
        |> depunctuate
        |> String.words
        |> List.foldl (\w d -> Dict.update w incrMaybe d) Dict.empty


depunctuate : String -> String
depunctuate =
    Regex.replace Regex.All (Regex.regex "[^a-z0-9 ]") (\_ -> "")


incrMaybe : Maybe Int -> Maybe Int
incrMaybe maybe =
    Maybe.withDefault 0 maybe + 1 |> Just
