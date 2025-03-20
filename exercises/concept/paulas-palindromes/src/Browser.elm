module Browser exposing (sandbox)

import Html exposing (Html)


type alias Sandbox msg model =
    { init : model
    , update : msg -> model -> model
    , view : model -> Html msg
    }



-- This file is a fake of `Browser.sandbox`, so that we can run the tests easily within the exercism online editor.


sandbox : Sandbox msg model -> Html msg
sandbox { init, view } =
    view init
