# Instructions

In this exercise you're a big sports fan and you've just discovered a passion for NBA basketball.
Being new to NBA basketball, you're doing a deep dive into NBA history, keeping track of teams, coaches, their win/loss stats and comparing them against each other.

As you don't yet have a favorite team, you'll also be developing an algorithm to figure out whether to root for a particular team.
You have seven tasks to help you develop your proprietary _root-for-a-team_ algorithm.

## 1. Define the model

Define the `Coach` type alias for a record with the following two fields:

- `name`: the coach's name, of type `String`.
- `formerPlayer`: indicates if the coach was a former player, of type `Bool`.

Define the `Stats` type alias for a record with the following two fields:

- `wins`: the number of wins, of type `Int`.
- `losses`: the number of losses, of type `Int`.

Define the `Team` type alias for a record with the following three fields:

- `name`: the team's name, of type `String`.
- `coach`: the team's coach, of type `Coach`.
- `stats`: the team's stats, of type `Stats`.

## 5. Replace the coach

NBA owners being impatient, you found that bad team results would often lead to the coach being replaced.
Implement the `replaceCoach` function that takes the new coach and the team as parameters, and returns the team but with the new coach:

```elm
let
    coach = { name = "Larry Bird", formerPlayer = True }
    stats = { wins = 58, losses =  24 }
    team = { name = "Indiana Pacers", coach = coach, stats =  stats }
    newCoach = { name = "Isiah Thomas", formerPlayer = True }
in
replaceCoach newCoach team
--> { name = "Indiana Pacers"
--  , coach = { name = "Isiah Thomas", formerPlayer = True }
--  , stats = { wins = 58, losses = 24 } }
```

## 6. Check for same team

While digging into stats, you're keeping lists of teams and their records.
Sometimes, you get things wrong and there are duplicate entries on your list.
Implement the `isSameTeam` function that takes two teams and returns `True` if they are the same team; otherwise, return `False`:

```elm
let
    pacersCoach = { name = "Larry Bird", formerPlayer = True }
    pacersStats = { wins = 58, losses = 24 }
    pacersTeam = { name = "Indiana Pacers", coach = pacersCoach, stats = pacersStats }

    lakersCoach = { name = "Del Harris", formerPlayer =  False }
    lakersStats = { wins = 61, losses = 21 }
    lakersTeam = { name = "LA Lakers", coach =  lakersCoach, stats = lakersStats }
in
isSameTeam pacersTeam lakersTeam
--> False
```

## 7. Check if you should root for a team

In the future, you plan to come up with a complicated algorithm about whether to root for a team or not, but for the first attempt, you have decided that you should root for any team has more wins than losses.

You want this function to be reusable in other contexts, so use an extensible record in the type signature to accept any record.
To keep the function as concise as possible, you want to use pattern matching to get the `stats` from the function parameter.
Implement the `rootForTeam` function that takes a team and returns `True` if you should root for that team; otherwise, return `False`.

```elm
let
    spursCoach = { name = "Gregg Popovich", formerPlayer =  False }
    spursStats = { wins = 56, losses = 26 }
    spursTeam = { name = "San Antonio Spurs", coach = spursCoach, stats = spursStats }
in
rootForTeam spursTeam
--> True
```
