module Tests exposing (tests)

import Expect
import Hangman exposing (Msg(..), init, update, view)
import Html exposing (Html)
import Test exposing (Test, describe, skip, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector


tests : Test
tests =
    describe "Hangman"
        [ -- skip <|
          test "Initially 9 failures are allowed and no letters are guessed" <|
            \() ->
                Hangman.init "loot"
                    |> Hangman.view
                    |> Query.fromHtml
                    |> Query.find [ Selector.tag "dl" ]
                    |> Query.has
                        [ Selector.all [ Selector.tag "dt", Selector.text "State" ]
                        , Selector.all [ Selector.tag "dd", Selector.text "Ongoing" ]
                        , Selector.all [ Selector.tag "dt", Selector.text "Word" ]
                        , Selector.all [ Selector.tag "dd", Selector.text "____" ]
                        , Selector.all [ Selector.tag "dt", Selector.text "Remaining failures" ]
                        , Selector.all [ Selector.tag "dd", Selector.text "9" ]
                        ]
        , skip <|
            test "After 10 failures the game is over" <|
                \() ->
                    Hangman.init "loot"
                        |> Hangman.update (Guess 'a')
                        |> Hangman.update (Guess 'b')
                        |> Hangman.update (Guess 'c')
                        |> Hangman.update (Guess 'd')
                        |> Hangman.update (Guess 'e')
                        |> Hangman.update (Guess 'f')
                        |> Hangman.update (Guess 'g')
                        |> Hangman.update (Guess 'h')
                        |> Hangman.update (Guess 'i')
                        |> Hangman.update (Guess 'j')
                        |> Hangman.view
                        |> Query.fromHtml
                        |> Query.find [ Selector.tag "dl" ]
                        |> Query.has
                            [ Selector.all [ Selector.tag "dt", Selector.text "State" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "Lose" ]
                            , Selector.all [ Selector.tag "dt", Selector.text "Word" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "____" ]
                            , Selector.all [ Selector.tag "dt", Selector.text "Remaining failures" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "0" ]
                            ]
        , skip <|
            test "Losing with several correct guesses" <|
                \() ->
                    Hangman.init "loot"
                        |> Hangman.update (Guess 't')
                        |> Hangman.update (Guess 'o')
                        |> Hangman.update (Guess 'a')
                        |> Hangman.update (Guess 'b')
                        |> Hangman.update (Guess 'c')
                        |> Hangman.update (Guess 'd')
                        |> Hangman.update (Guess 'e')
                        |> Hangman.update (Guess 'f')
                        |> Hangman.update (Guess 'g')
                        |> Hangman.update (Guess 'h')
                        |> Hangman.update (Guess 'i')
                        |> Hangman.update (Guess 'j')
                        |> Hangman.view
                        |> Query.fromHtml
                        |> Query.find [ Selector.tag "dl" ]
                        |> Query.has
                            [ Selector.all [ Selector.tag "dt", Selector.text "State" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "Lose" ]
                            , Selector.all [ Selector.tag "dt", Selector.text "Word" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "_oot" ]
                            , Selector.all [ Selector.tag "dt", Selector.text "Remaining failures" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "0" ]
                            ]
        , skip <|
            test "Feeding a correct letter removes underscores" <|
                \() ->
                    Hangman.init "loot"
                        |> Hangman.update (Guess 't')
                        |> Hangman.view
                        |> Query.fromHtml
                        |> Query.find [ Selector.tag "dl" ]
                        |> Query.has
                            [ Selector.all [ Selector.tag "dd", Selector.text "Ongoing" ]
                            , Selector.all [ Selector.tag "dt", Selector.text "Word" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "___t" ]
                            , Selector.all [ Selector.tag "dt", Selector.text "Remaining failures" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "9" ]
                            ]
        , skip <|
            test "Feeding a correct letter twice counts as a failure" <|
                \() ->
                    Hangman.init "loot"
                        |> Hangman.update (Guess 't')
                        |> Hangman.update (Guess 't')
                        |> Hangman.view
                        |> Query.fromHtml
                        |> Query.find [ Selector.tag "dl" ]
                        |> Query.has
                            [ Selector.all [ Selector.tag "dt", Selector.text "State" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "Ongoing" ]
                            , Selector.all [ Selector.tag "dt", Selector.text "Word" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "___t" ]
                            , Selector.all [ Selector.tag "dt", Selector.text "Remaining failures" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "8" ]
                            ]
        , skip <|
            test "Guessing a repeated letter reveals all instances" <|
                \() ->
                    Hangman.init "loot"
                        |> Hangman.update (Guess 't')
                        |> Hangman.update (Guess 't')
                        |> Hangman.update (Guess 'o')
                        |> Hangman.view
                        |> Query.fromHtml
                        |> Query.find [ Selector.tag "dl" ]
                        |> Query.has
                            [ Selector.all [ Selector.tag "dt", Selector.text "State" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "Ongoing" ]
                            , Selector.all [ Selector.tag "dt", Selector.text "Word" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "_oot" ]
                            , Selector.all [ Selector.tag "dt", Selector.text "Remaining failures" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "8" ]
                            ]
        , skip <|
            test "Getting all the letters right makes for a win" <|
                \() ->
                    Hangman.init "loot"
                        |> Hangman.update (Guess 't')
                        |> Hangman.update (Guess 't')
                        |> Hangman.update (Guess 'o')
                        |> Hangman.update (Guess 'l')
                        |> Hangman.view
                        |> Query.fromHtml
                        |> Query.find [ Selector.tag "dl" ]
                        |> Query.has
                            [ Selector.all [ Selector.tag "dt", Selector.text "State" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "Win" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "loot" ]
                            , Selector.all [ Selector.tag "dt", Selector.text "Remaining failures" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "8" ]
                            ]
        , skip <|
            test "Winning on the last guess is still a win" <|
                \() ->
                    Hangman.init "loot"
                        |> Hangman.update (Guess 'a')
                        |> Hangman.update (Guess 'b')
                        |> Hangman.update (Guess 'c')
                        |> Hangman.update (Guess 'd')
                        |> Hangman.update (Guess 'e')
                        |> Hangman.update (Guess 'f')
                        |> Hangman.update (Guess 'g')
                        |> Hangman.update (Guess 'h')
                        |> Hangman.update (Guess 'i')
                        |> Hangman.update (Guess 't')
                        |> Hangman.update (Guess 'o')
                        |> Hangman.update (Guess 'l')
                        |> Hangman.view
                        |> Query.fromHtml
                        |> Query.find [ Selector.tag "dl" ]
                        |> Query.has
                            [ Selector.all [ Selector.tag "dt", Selector.text "State" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "Win" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "loot" ]
                            , Selector.all [ Selector.tag "dt", Selector.text "Remaining failures" ]
                            , Selector.all [ Selector.tag "dd", Selector.text "0" ]
                            ]
        , skip <|
            test "Guessing after a lose is error" <|
                \() ->
                    Hangman.init "loot"
                        |> Hangman.update (Guess 'a')
                        |> Hangman.update (Guess 'b')
                        |> Hangman.update (Guess 'c')
                        |> Hangman.update (Guess 'd')
                        |> Hangman.update (Guess 'e')
                        |> Hangman.update (Guess 'f')
                        |> Hangman.update (Guess 'g')
                        |> Hangman.update (Guess 'h')
                        |> Hangman.update (Guess 'i')
                        |> Hangman.update (Guess 'j')
                        |> Hangman.update (Guess 'k')
                        |> Hangman.view
                        |> Query.fromHtml
                        |> Query.find [ Selector.tag "p" ]
                        |> Query.has [ Selector.text "cannot guess after the game is lost" ]
        , skip <|
            test "Guessing after a win is error" <|
                \() ->
                    Hangman.init "loot"
                        |> Hangman.update (Guess 't')
                        |> Hangman.update (Guess 'o')
                        |> Hangman.update (Guess 'l')
                        |> Hangman.update (Guess 'l')
                        |> Hangman.view
                        |> Query.fromHtml
                        |> Query.find [ Selector.tag "p" ]
                        |> Query.has [ Selector.text "cannot guess after the game is won" ]
        ]
