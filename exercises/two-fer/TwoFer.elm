module TwoFer exposing (twoFer)


twoFer : Maybe String -> String
twoFer name =
    case name of
        Just name_ ->
            "One for " ++ name_ ++ ", one for me."

        Nothing ->
            "One for you, one for me."
