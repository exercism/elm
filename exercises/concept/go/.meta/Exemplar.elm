module ApplyRules exposing (..)

import Go exposing (..)


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
