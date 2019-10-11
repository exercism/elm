module Bowling exposing (Rolls, score)


type alias Rolls =
    List Int


score : Rolls -> Result String Int
score rolls =
    Debug.todo "implement this function"
