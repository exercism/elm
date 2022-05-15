module TopScorers exposing (..)

import Dict as Dict exposing (Dict)
import TopScorersSupport exposing (PlayerName)



-- should mostly be doing the higher level things, like map, and less often doing
-- the low level things, like get, delete
-- todo: mention this in the instructions


updateGoalCountForPlayer : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
updateGoalCountForPlayer playerName playerGoalCounts =
    -- Debug.todo "implement updateGoalCountForPlayer function, to initialise or increment the goalcount for PlayerName"
    let
        updatePlayer existingGoalCount =
            case existingGoalCount of
                Just goalCount ->
                    Just (goalCount + 1)

                Nothing ->
                    Just 1
    in
    Dict.update playerName updatePlayer playerGoalCounts


aggregateScorers : List PlayerName -> Dict PlayerName Int
aggregateScorers playerNames =
    -- Debug.todo "Use List.foldl and updateGoalCountForPlayer to convert the list in to a Dict"
    List.foldl updateGoalCountForPlayer Dict.empty playerNames


removeInsignificantPlayers : Int -> Dict PlayerName Int -> Dict PlayerName Int
removeInsignificantPlayers goalThreshold playerGoalCounts =
    -- Debug.todo "implement removeInsignificantPlayers function, to remove players who have scored less than the threshold number of goals"
    Dict.filter (\_ goalCount -> goalCount < goalThreshold) playerGoalCounts


resetPlayerGoalCount : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
resetPlayerGoalCount playerName playerGoalCounts =
    -- Debug.todo "implement resetPlayerGoalCount function, to remove players who have scored less than the threshold number of goals"
    Dict.insert playerName 0 playerGoalCounts


formatPlayer : PlayerName -> Dict PlayerName Int -> String
formatPlayer playerName playerGoalCounts =
    -- Debug.todo "implement formatPlayer function, for use on the player profile page"
    Dict.get playerName playerGoalCounts
        |> Maybe.map (\goalCount -> playerName ++ ": " ++ String.fromInt goalCount)
        |> Maybe.withDefault (playerName ++ ": 0")


formatPlayers : Dict PlayerName Int -> String
formatPlayers players =
    -- Debug.todo "implement formatPlayers function, for use on the Top Scorers page"
    Dict.toList players
        |> List.reverse
        |> List.map (\( playerName, goalCount ) -> playerName ++ ": " ++ String.fromInt goalCount)
        |> String.join ", "


combineGames : Dict PlayerName Int -> Dict PlayerName Int -> Dict PlayerName Int
combineGames game1 game2 =
    -- Debug.todo "implement combineGames function, to calculate total scores played in both games"
    Dict.merge
        -- when only in game 1
        (\playerName game1GoalCount playerGoalCounts -> Dict.insert playerName game1GoalCount playerGoalCounts)
        -- when in game 1 and game2
        (\playerName game1GoalCount game2GoalCount playerGoalCounts -> Dict.insert playerName (game1GoalCount + game2GoalCount) playerGoalCounts)
        -- when only in game 2
        (\playerName game2GoalCount playerGoalCounts -> Dict.insert playerName game2GoalCount playerGoalCounts)
        game1
        game2
        Dict.empty
