module TracksOnTracksOnTracks exposing (..)

import List as List


newList : List a
newList =
    []


existingList : List String
existingList =
    [ "Elm", "Clojure", "Haskell" ]


addLanguage : String -> List String -> List String
addLanguage language languages =
    language :: languages


countLanguages : List a -> Int
countLanguages languages =
    List.length languages


reverseList : List String -> List String
reverseList languages =
    List.reverse languages


excitingList : List String -> Bool
excitingList languages =
    case languages of
        "Elm" :: _ ->
            True

        [ _, "Elm" ] ->
            True

        [ _, "Elm", _ ] ->
            True

        _ ->
            False
