module GoSupport exposing (..)


type Player
    = Black
    | White


type alias Game =
    { whiteCapturedStones : Int
    , blackCapturedStones : Int
    , player : Player
    , error : String
    }


type alias Rule =
    Game -> Result String Game


type alias NonValidatingRule =
    Game -> Game


changePlayer : Game -> Game
changePlayer game =
    let
        newPlayer =
            if game.player == White then
                Black

            else
                White
    in
    { game | player = newPlayer }
