module Tests exposing (..)

import Expect
import Go exposing (..)
import GoSupport exposing (..)
import Test exposing (..)


identityRule : Game -> Result String Game
identityRule game =
    Ok game


errRule : String -> Game -> Result String Game
errRule msg _ =
    Err msg


vanillaGame : Game
vanillaGame =
    Game 0 0 White ""


koRule : String
koRule =
    "Cannot repeat a previously played board position"


libertyRule : String
libertyRule =
    "Cannot place a stone with no liberties"


oneStonePerPointRule : String
oneStonePerPointRule =
    "You can't put a stone on top of another stone"


addWhiteCapturedStone : Game -> Game
addWhiteCapturedStone game =
    { game | whiteCapturedStones = 1 }


tests : Test
tests =
    describe "Go"
        [ describe "1"
            [ test "should change the player if all rules pass" <|
                \() ->
                    applyRules vanillaGame identityRule identity identityRule identityRule
                        |> Expect.equal
                            (changePlayer vanillaGame)
            , test "should retain the error and player if koRule fails" <|
                \() ->
                    applyRules vanillaGame identityRule identity identityRule (errRule koRule)
                        |> Expect.equal
                            { vanillaGame | error = koRule }
            , test "should retain the error and player if libertyRule fails" <|
                \() ->
                    applyRules vanillaGame identityRule identity (errRule libertyRule) identityRule
                        |> Expect.equal
                            { vanillaGame | error = libertyRule }
            , test "should retain the error and player if oneStonePerPointRule fails" <|
                \() ->
                    applyRules vanillaGame (errRule oneStonePerPointRule) identity identityRule identityRule
                        |> Expect.equal
                            { vanillaGame | error = oneStonePerPointRule }
            , test "should retain changes from captureRule and change player" <|
                \() ->
                    applyRules vanillaGame identityRule addWhiteCapturedStone identityRule identityRule
                        |> Expect.equal
                            (vanillaGame |> addWhiteCapturedStone |> changePlayer)
            , test "should discard changes from captureRule if subsequent rule fails" <|
                \() ->
                    applyRules vanillaGame identityRule addWhiteCapturedStone identityRule (errRule koRule)
                        |> Expect.equal
                            { vanillaGame | error = koRule }
            ]
        ]
