module Browser exposing (sandbox)

import Html exposing (Html)


type alias Sandbox msg model =
    { init : model
    , update : msg -> model -> model
    , view : model -> Html msg
    }


sandbox :
    Sandbox msg model
    -> Html msg --Sandbox msg model
sandbox { init, view } =
    view init
