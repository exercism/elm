module AggregateScorers exposing (..)

import Dict exposing (..)

-- should mostly be doing the higher level things, like map, and less often doing
-- the low level things, like get, delete
-- todo: mention this in the instructions


type PlayerName = String


aggregateScorers : List PlayerName -> Dict PlayerName Int
aggregateScorers playerNames =
    Debug.todo "Use List.foldl and updateGoalCountForPlayer to convert the list in to a Dict"
    --List.foldl updateGoalCountForPlayer Dict.empty playerNames


updateGoalCountForPlayer : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
updateGoalCountForPlayer playerName playerGoalCounts =
    Debug.todo "implement updateGoalCountForPlayer function, to initialise or increment the goalcount for PlayerName"
    -- let
    --     updatePlayer existingPlayer =
    --         case existingPlayer of
    --             Just player ->
    --                 { player | goals = player.goals + 1 }

    --             Nothing ->
    --                 (Player playerName 1)
    -- in
    --     Dict.update playerName updatePlayer playerGoalCounts


removeInsignificantPlayers: Int -> Dict PlayerName Int
removeInsignificantPlayers goalThreshold playerGoalCounts = 
    Debug.todo "implement removeInsignificantPlayers function, to remove players who have scored less than the threshold number of goals"
    -- Dict.filter (\(_, goalCount) -> goalCount < goalThreshold) playerGoalCounts


resetPlayerGoalCount: PlayerName -> Dict PlayerName Int
resetPlayerGoalCount playerName playerGoalCounts =
    Debug.todo "implement removeInsignificantPlayers function, to remove players who have scored less than the threshold number of goals"
    -- Dict.insert playerName 0 playerGoalCounts

formatPlayer: PlayerName -> String
formatPlayer playerName = 
    Debug.todo "implement formatPlayer function, for use on the player profile page"
    -- Dict.get playerName
    -- |> Maybe.map (\goalCount -> playerName ++ ": " + (toString goalCount)
    -- |> Maybe.withDefault (playerName ++ ": 0"


formatPlayers : Dict PlayerName Int -> String
formatPlayers players =
    Debug.todo "implement formatPlayers function, for use on the Top Scorers page"
    -- Dict.toList players
    -- |> List.reverse
    -- |> List.map \(playerName, goalCount) -> playerName ++ ": " ++ toString(goals)
    -- |> String.join ", "
