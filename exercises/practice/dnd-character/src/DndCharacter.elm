module DndCharacter exposing (Character, ability, character, modifier)

import Random exposing (Generator)


type alias Character =
    { strength : Int
    , dexterity : Int
    , constitution : Int
    , intelligence : Int
    , wisdom : Int
    , charisma : Int
    , hitpoints : Int
    }


modifier : Int -> Int
modifier score =
    Debug.todo "Please implement modifier"


ability : Generator Int
ability =
    Random.lazy (\_ -> Debug.todo "Please implement ability")


character : Generator Character
character =
    Random.lazy (\_ -> Debug.todo "Please implement character")
