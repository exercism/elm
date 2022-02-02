module Go exposing (..)


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


applyRules : Game -> Rule -> NonValidatingRule -> Rule -> Rule -> Game
applyRules game oneStonePerPointRule captureRule libertyRule koRule =
    let
        updatedGameOrError =
            oneStonePerPointRule game
                |> Result.map captureRule
                |> Result.andThen libertyRule
                |> Result.andThen koRule
                |> Result.map changePlayer
    in
    case updatedGameOrError of
        Ok updatedGame ->
            updatedGame

        Err msg ->
            { game | error = msg }
