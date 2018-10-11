module HelloWorld exposing (helloWorld)


helloWorld : Maybe String -> String
helloWorld name =
    case name of
        Just name_ ->
            "Hello, " ++ name_ ++ "!"

        Nothing ->
            "Hello, World!"
