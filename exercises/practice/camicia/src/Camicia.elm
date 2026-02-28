module Camicia exposing (Card(..), Status(..), simulateGame)

import Set exposing (Set)


type Card
    = Ace
    | Two
    | Three
    | Four
    | Five
    | Six
    | Seven
    | Eight
    | Nine
    | Ten
    | Jack
    | Queen
    | King


type Status
    = Finished
    | Loop


simulateGame : List Card -> List Card -> { status : Status, cards : Int, tricks : Int }
simulateGame playerA playerB =
    Debug.todo "Please implement simulateGame"
