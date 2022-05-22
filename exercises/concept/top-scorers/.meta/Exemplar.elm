module TopScorers exposing (..)

import Dict exposing (Dict)
import TopScorersSupport exposing (PlayerName)


updateGoalCountForPlayer : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
updateGoalCountForPlayer playerName playerGoalCounts =
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
    List.foldl updateGoalCountForPlayer Dict.empty playerNames


removeInsignificantPlayers : Int -> Dict PlayerName Int -> Dict PlayerName Int
removeInsignificantPlayers goalThreshold playerGoalCounts =
    Dict.filter (\_ goalCount -> goalCount >= goalThreshold) playerGoalCounts


resetPlayerGoalCount : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
resetPlayerGoalCount playerName playerGoalCounts =
    Dict.insert playerName 0 playerGoalCounts


formatPlayer : PlayerName -> Dict PlayerName Int -> String
formatPlayer playerName playerGoalCounts =
    Dict.get playerName playerGoalCounts
        |> Maybe.map (\goalCount -> playerName ++ ": " ++ String.fromInt goalCount)
        |> Maybe.withDefault (playerName ++ ": 0")


formatPlayers : Dict PlayerName Int -> String
formatPlayers players =
    Dict.toList players
        |> List.map (\( playerName, goalCount ) -> playerName ++ ": " ++ String.fromInt goalCount)
        |> String.join ", "


combineGames : Dict PlayerName Int -> Dict PlayerName Int -> Dict PlayerName Int
combineGames game1 game2 =
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
