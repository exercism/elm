module Main exposing (..)

import Browser
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onInput)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { content : String
    }


init : Model
init =
    { content = "" }



-- UPDATE


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }



-- VIEW


isPalindrome : String -> String
isPalindrome content =
    if content == (content |> String.toLower |> String.reverse) then
        "This is a palindrome"

    else
        "Not a palindrome"


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to check for a palindrome", value model.content, onInput Change ] []
        , div [] [ text (isPalindrome model.content) ]
        ]
