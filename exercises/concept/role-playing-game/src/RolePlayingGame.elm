module RolePlayingGame exposing (Player, castSpell, revive)


type alias Player =
    { level : Int
    , health : Int
    , mana : Maybe Int
    }


revive : Player -> Maybe Player
revive player =
    Debug.todo "Please implement this function"


castSpell : Int -> Player -> ( Player, Int )
castSpell manaCost player =
    Debug.todo "Please implement this function"
