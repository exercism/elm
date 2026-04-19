module Hangman exposing (Msg(..), init, update, view)

import Html exposing (Html)



-- MODEL


type alias Model =
    {}


init : String -> Model
init word =
    {}



-- UPDATE


type Msg
    = Guess Char


update : Msg -> Model -> Model
update msg model =
    case msg of
        Guess letter ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    Html.div [] []
