module GottaSnatchEmAll exposing (..)

import Set exposing (Set)


type alias Card =
    String


newCollection : Card -> Set Card
newCollection card =
    Debug.todo "Please implement newCollection"


addCard : Card -> Set Card -> ( Bool, Set Card )
addCard card collection =
    Debug.todo "Please implement addCard"


tradeCard : Card -> Card -> Set Card -> ( Bool, Set Card )
tradeCard yourCard theirCard collection =
    Debug.todo "Please implement tradeCard"


removeDuplicates : List Card -> List Card
removeDuplicates cards =
    Debug.todo "Please implement removeDuplicates"


extraCards : Set Card -> Set Card -> Int
extraCards yourCollection theirCollection =
    Debug.todo "Please implement extraCards"


boringCards : List (Set Card) -> List Card
boringCards collections =
    Debug.todo "Please implement boringCards"


totalCards : List (Set Card) -> Int
totalCards collections =
    Debug.todo "Please implement totalCards"


splitShinyCards : Set Card -> ( List Card, List Card )
splitShinyCards collection =
    Debug.todo "Please implement splitShinyCards"
