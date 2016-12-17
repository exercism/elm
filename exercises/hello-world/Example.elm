module HelloWorld exposing (..)


helloWorld : Maybe String -> String
helloWorld name =
    case name of
        Just name ->
            "Hello, " ++ name ++ "!"

        Nothing ->
            "Hello, World!"
