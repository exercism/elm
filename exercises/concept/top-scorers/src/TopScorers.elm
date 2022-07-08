module TopScorers exposing (..)

import Dict exposing (Dict)
import TopScorersSupport exposing (PlayerName)


updateGoalCountForPlayer : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
updateGoalCountForPlayer playerName playerGoalCounts =
    Debug.todo "implement updateGoalCountForPlayer function, to initialise or increment the goalcount for PlayerName"


aggregateScorers : List PlayerName -> Dict PlayerName Int
aggregateScorers playerNames =
    Debug.todo "Use List.foldl and updateGoalCountForPlayer to convert the list into a Dict"


removeInsignificantPlayers : Int -> Dict PlayerName Int -> Dict PlayerName Int
removeInsignificantPlayers goalThreshold playerGoalCounts =
    Debug.todo "implement removeInsignificantPlayers function, to remove players who have scored less than the threshold number of goals"


resetPlayerGoalCount : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
resetPlayerGoalCount playerName playerGoalCounts =
    Debug.todo "implement resetPlayerGoalCount function, to reset the score of a player"


formatPlayer : PlayerName -> Dict PlayerName Int -> String
formatPlayer playerName playerGoalCounts =
    Debug.todo "implement formatPlayer function, for use on the player profile page"


formatPlayers : Dict PlayerName Int -> String
formatPlayers players =
    Debug.todo "implement formatPlayers function, for use on the Top Scorers page"


combineGames : Dict PlayerName Int -> Dict PlayerName Int -> Dict PlayerName Int
combineGames game1 game2 =
    Debug.todo "implement combineGames function, to calculate total scores played in both games"
