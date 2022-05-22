# Instructions

Your task is to take a list of scorers for a game, and count how many goals each player has scored.

`PlayerName` is a type alias for `String`, to make the code easier to read, and to distinguish this use of `String` from other uses of `String`.

## 1. Aggregate scorers

First implement `updateGoalCountForPlayer` to initialise or increment the goal count for a player.
Then implement the `aggregateScorers` function to count how many goals each player has scored, by using `updateGoalCountForPlayer`.
This function takes a `List PlayerName`(the names of the players that scored the goals, that can contain duplicate player names), and returns a`Dict PlayerName Int` containing all the players in the list along with how many goals they have scored.

```elm
aggregateScorers [ "Betty", "Cedd", "Betty" ]
--> Dict.fromList [ ( "Betty", 2 ), ( "Cedd", 1 ) ]
```

## 2. Remove insignificant players

Implement the `removeInsignificantPlayers` function, to filter out any players that have scored less goals than the threshold.

```elm
removeInsignificantPlayers 2 (Dict.fromList [ ( "Betty", 2 ), ( "Cedd", 1 ) ] )
--> Dict.fromList [ ( "Betty", 2 ) ]
```

## 3. Reset player goal count

Implement the `resetPlayerGoalCount` function to reset the goals scored to zero for a player.

```elm
resetPlayerGoalCount "Cedd" (Dict.fromList [ ( "Betty", 2 ), ( "Cedd", 1 ) ] )
--> Dict.fromList [ ( "Betty", 2 ), ( "Cedd", 0 ) ]
```

## 4. Format the goal count for a single player

Implement the `formatPlayer` function for formatting the goal count for a single player as a string. If the player does not exit in the dict, assume they have a zero goal count.

```elm
formatPlayer "Betty" (Dict.fromList [ ( "Betty", 2 ), ( "Cedd", 1 ) ] )
--> "Betty: 2"
```

## 5. Format the goal count for all players

Implement the `formatPlayers` function for formatting the goal count for all players as a string. The players should be ordered by player name.

```elm
formatPlayers (Dict.fromList [ ( "Betty", 2 ), ( "Cedd", 1 ) ] )
--> "Betty: 2, Cedd: 1"
```

## 6. Combine games

Implement the `combineGames` function, counting the total number of goals each player has scored in both games.

```elm
combine Games
  (Dict.fromList [ ( "Betty", 2 ), ( "Cedd", 1 ) ] )
  (Dict.fromList [ ( "Betty", 2 ), ( "Luigi", 3 ) ] )
--> Dict.fromList [ ( "Betty", 4 ), ( "Cedd", 1 ), ( "Luigi", 3 ) ]
```
