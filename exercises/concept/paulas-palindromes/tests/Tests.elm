module Tests exposing (tests)

import Expect
import Main exposing (..)
import Test exposing (..)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector exposing (tag, text)


tests : Test
tests =
    describe "Paulas Palindromes"
        [ describe "1"
            [ test "Model is exposed" <|
                \_ ->
                    let
                        identity : Main.Model -> Main.Model
                        identity model =
                            model
                    in
                    Expect.pass
            , test "Msg is exposed" <|
                \_ ->
                    let
                        identity : Msg -> Msg
                        identity msg =
                            msg
                    in
                    Expect.pass
            ]
        , describe "2"
            [ test "update should change the model content" <|
                \_ ->
                    update (Main.Change "new content") { content = "" }
                        |> Expect.equal { content = "new content" }
            ]
        , describe "3"
            [ test "view should identify content as a palindrome" <|
                \_ ->
                    view { content = "tacocat" }
                        |> Query.fromHtml
                        |> Query.has [ text "This is a palindrome" ]
            , test "view should identify content that is not a palindrome" <|
                \_ ->
                    view { content = "wrapcat" }
                        |> Query.fromHtml
                        |> Query.has [ text "Not a palindrome" ]
            , test "view should create Msg.Change onChange" <|
                \_ ->
                    view { content = "" }
                        |> Query.fromHtml
                        |> Query.find [ tag "input" ]
                        |> Event.simulate (Event.input "cat")
                        |> Event.expect (Main.Change "cat")
            ]
        , describe "4"
            [ test "init should return a model empty content" <|
                \_ ->
                    init
                        |> Expect.equal { content = "" }
            ]
        , describe "5"
            [ test "main should create the sandbox" <|
                \_ ->
                    -- This is a bit of a hack, and doesn't test the update function is passed,
                    -- but elm make requires us to return something it understands, and an
                    -- Html Msg is the only such thing we can feasibly create.
                    main
                        |> Expect.equal (view init)
            ]
        ]
