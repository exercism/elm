# Introduction

Elm is a fully functional language, so there are no statements, just expressions, and functions are always a single expression.

This encourages small, simple functions and is generally a good thing, but sometimes functions are unavoidably more complex, and we need a way to ensure that these functions can be written elegantly.

This is where `let` expressions come in. They have two parts, a `let` section where you can create as many definitions as you need, and then an `in` section, which is a single expression that can use these definitions.

In computing terms, `let` creates a scope that is local to the expression in `in`.

The let expression is useful in a few situations:

- For simplifying expressions
- For naming the results of intermediate expressions
- Splitting an expression in to smaller bits if it is getting large

You can do most things inside a `let` expression, including destructuring (more details on this in later exercises), however the following are not allowed:

- Custom Types
- Type Alias'
- Name shadowing (you cannot redefine / reuse a name that is already in scope)

## Simplifying expressions

This expression defines adds the cube's of 3 numbers, but it is hard to read, and it would be easy for the calculation to be different for the different numbers.

```elm
(a * a * a) + (b * b * b) + (c * c * c)
```

We can define a `cube` function in a `let` expressions to make the calculation simpler, more expressive, and safer. This function could have a type annotation, but in idiomatic Elm code this is relatively rare.

```elm
let
  cube x = x * x * x
in
  cube a + cube b + cube c
```

## Naming the results of intermediate expressions

This code defines sideArea and topArea to make the calculation simpler and more expressive.

```elm
cylinderArea : Float -> Float -> Float
cylinderArea radius height =
    let
        sideArea = 2 * pi * radius * height
        topArea = pi * radius ^2
    in
        sideArea + 2 * topArea
```

## Splitting a large expression

This code takes a list of results of games played between teams in a league, and converts it in to a league table.

It's not important to understand exactly how it works, but hopefully it is obvious that it would be very large if written as a single expression, without `let`.

```elm
calculateLeagueTable : LeagueGames -> LeagueTable
calculateLeagueTable leagueGames =
    let
        homeTeamNames =
            List.map (\game -> game.homeTeamName) leagueGames.games

        awayTeamNames =
            List.map (\game -> game.awayTeamName) leagueGames.games

        teamNames =
            List.append homeTeamNames awayTeamNames |> unique

        unpositionedTeams =
            List.map (unpositionedTeam leagueGames.games) teamNames

        sortedTeams =
            List.sortWith (by .points DESC |> andThen .goalDifference DESC |> andThen .goalsFor DESC) unpositionedTeams

        positionedTeams =
            List.indexedMap positionedTeam sortedTeams
    in
    LeagueTable
        leagueGames.leagueTitle
        positionedTeams
```
