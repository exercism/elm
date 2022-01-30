module ApplyRules exposing (..)

import Go exposing (..)


applyRules : Game -> Rule -> NonValidatingRule -> Rule -> Rule -> Game
applyRules game oneStonePerPointRule captureRule libertyRule koRule =
    Debug.todo "Please implement the `applyRules` function"
