module Tests exposing (tests)

import Expect
import Main exposing (Msg(..), init, main, update, view)
import Test exposing (..)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector exposing (tag, text)


tests : Test
tests =
    describe "ArlosAlphabetiser"
        [ describe "1"
            [ test "init should return a model empty content" <|
                \_ ->
                    init
                        |> Expect.equal { content = "" }
            ]
        , describe "2"
            [ test "update should change the model content" <|
                \_ ->
                    update (Change "new content") { content = "" }
                        |> Expect.equal { content = "new content" }
            ]
        , describe "3"
            [ test "view should alphabetise content" <|
                \_ ->
                    view { content = "cats" }
                        |> Query.fromHtml
                        |> Query.has [ text "acst" ]
            , test "view should blah" <|
                \_ ->
                    view { content = "" }
                        |> Query.fromHtml
                        |> Query.find [ tag "input" ]
                        |> Event.simulate (Event.input "cats")
                        |> Event.expect (Change "cats")
            ]
        , describe "4"
            [ test "main should create the sandbox" <|
                \_ ->
                    -- This is a bit of a hack, and doesn't test the update function is passed,
                    -- but elm make requires us to return something it understands, and an
                    -- Html Msg is the only such thing we can feasibly create.
                    main
                        |> Expect.equal (view init)
            ]
        ]
