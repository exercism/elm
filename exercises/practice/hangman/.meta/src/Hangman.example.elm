module Hangman exposing (Msg(..), init, update, view)

import Html exposing (Html)


type State
    = Ongoing
    | Win
    | Lose



-- MODEL


type alias Model =
    { state : State
    , word : List Char
    , maskedWord : List Char
    , remainingFailures : Int
    , error : Maybe String
    }


init : String -> Model
init word =
    { state = Ongoing
    , word = String.toList word
    , maskedWord = List.repeat (String.length word) '_'
    , remainingFailures = 9
    , error = Nothing
    }



-- UPDATE


type Msg
    = Guess Char


update : Msg -> Model -> Model
update msg model =
    case msg of
        Guess letter ->
            case model.state of
                Win ->
                    { model | error = Just "cannot guess after the game is won" }

                Lose ->
                    { model | error = Just "cannot guess after the game is lost" }

                Ongoing ->
                    guess letter model


guess : Char -> Model -> Model
guess letter ({ word, maskedWord, remainingFailures } as model) =
    if List.member letter word then
        let
            revealLetter wordChar maskedChar =
                if wordChar == letter then
                    ( '_', letter )

                else
                    ( wordChar, maskedChar )

            ( newWord, newMaskedWord ) =
                List.map2 revealLetter word maskedWord |> List.unzip

            newState =
                if List.all (\c -> c == '_') newWord then
                    Win

                else
                    Ongoing
        in
        { model | maskedWord = newMaskedWord, word = newWord, state = newState }

    else if remainingFailures == 0 then
        { model | state = Lose }

    else
        { model | remainingFailures = remainingFailures - 1 }



-- VIEW


view : Model -> Html Msg
view { state, maskedWord, remainingFailures, error } =
    case error of
        Just errorMessage ->
            Html.div [] [ Html.p [] [ Html.text errorMessage ] ]

        Nothing ->
            Html.div []
                [ Html.dl []
                    [ Html.dt [] [ Html.text "State" ]
                    , Html.dd [] [ Html.text (viewState state) ]
                    , Html.dt [] [ Html.text "Word" ]
                    , Html.dd [] [ Html.text (String.fromList maskedWord) ]
                    , Html.dt [] [ Html.text "Remaining failures" ]
                    , Html.dd [] [ Html.text (String.fromInt remainingFailures) ]
                    ]
                ]


viewState : State -> String
viewState state =
    case state of
        Ongoing ->
            "Ongoing"

        Win ->
            "Win"

        Lose ->
            "Lose"
