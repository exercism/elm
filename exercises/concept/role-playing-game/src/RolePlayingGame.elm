module RolePlayingGame exposing (Player, castSpell, introduce, revive)


type alias Player =
    { name : Maybe String
    , level : Int
    , health : Int
    , mana : Maybe Int
    }


introduce : Player -> String
introduce { name } =
    Debug.todo "Please implement this function"


revive : Player -> Maybe Player
revive player =
    Debug.todo "Please implement this function"


castSpell : Int -> Player -> ( Player, Int )
castSpell manaCost player =
    Debug.todo "Please implement this function"
