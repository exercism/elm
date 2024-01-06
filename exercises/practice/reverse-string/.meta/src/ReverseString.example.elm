module ReverseString exposing (reverse)


reverse : String -> String
reverse str =
    String.foldl String.cons "" str
