module Yacht exposing (Category(..), score)


type Category
    = Ones
    | Twos
    | Threes
    | Fours
    | Fives
    | Sixes
    | FullHouse
    | FourOfAKind
    | LittleStraight
    | BigStraight
    | Choice
    | Yacht


score : List Int -> Category -> Int
score dice category =
    Debug.todo "Please implement score"
