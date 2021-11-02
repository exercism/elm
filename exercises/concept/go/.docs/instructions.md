# Instructions

In this exercise, you'll be applying the [rules of the game of Go](https://matmoore.github.io/learngo/). The rules themselves are already written, you just need to apply them in order to update the Game and to handle any errors / violations of the rules.

The game is represented as follows:

```elm
type Player
    = Black
    | White


type alias Game =
    { whiteCapturedStones : Int
    , blackCapturedStones : Int
    , player : Player
    , error : String
    }
```

There are 4 rules in the game:

- Each point can only have one stone (oneStonePerPointRule)
- Opposition stones can be captured! (captureRule)
- You can not place a stone where it would capture itself (libertyRule)
- You can not use the same point twice (koRule)

## 1. Apply the rules

Write the content of the `applyRules` function, which takes an initial `Game` and a set of rules, and returns the new `Game` after the rules have been applied.

`oneStonePerPointRule`, `libertyRule` and `koRule` all check for violations of the rules, and may return an error, and so have the return type of `Result String Game`. If any of these rules fail, the original game should be returned, but with the `error` field updated with the relevant error.

`captureRule` does not check for violations and so cannot fail (although it can return a changed `Game`) and so has the return type of `Game`.

If all the rules pass, then any changes to `Game` from the rules should be kept, and the player should be changed. The `changePlayer` function is provided to do this.

```elm
applyRules : Game -> Rule -> NonValidatingRule -> Rule -> Rule -> Game
applyRules game oneStonePerPointRule captureRule libertyRule koRule =
--> If all rules pass, return a `Game` with all changes from the rules applied, and changePlayer
--> If any rule fails, return the original Game, but with the error field set
```
