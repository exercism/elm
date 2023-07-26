-- todo, make this a shell once tests are working


module MagicianInTraining exposing (..)

import Array exposing (Array)


type alias Deck =
    Array Int


getCard : Int -> Deck -> Maybe Int
getCard index deck =
    Array.get index deck


setCard : Int -> Int -> Deck -> Deck
setCard index newCard deck =
    Array.set index newCard deck


addCard : Int -> Deck -> Deck
addCard newCard deck =
    Array.push newCard deck


removeCard : Int -> Deck -> Deck
removeCard index deck =
    -- Removing from an array is surprisingly complicated. The Array.Extra module has your back here.
    Array.append
        (Array.slice 0 index deck)
        (Array.slice (index + 1) (Array.length deck) deck)


evenCardCount : Deck -> Int
evenCardCount deck =
    Array.filter (\card -> modBy 2 card == 0) deck
        |> Array.length
