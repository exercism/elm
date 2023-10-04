module SqueakyClean exposing (clean, clean1, clean2, clean3, clean4)


clean1 : String -> String
clean1 =
    String.replace " " "_"


clean2 : String -> String
clean2 str =
    List.foldl (\ctrl -> String.replace ctrl "[CTRL]") (clean1 str) [ "\n", "\u{000D}", "\t" ]


clean3 : String -> String
clean3 str =
    case String.split "-" (clean2 str) of
        [] ->
            ""

        first :: rest ->
            String.concat (first :: List.map capitalize rest)


capitalize : String -> String
capitalize str =
    case String.uncons str of
        Nothing ->
            str

        Just ( first, rest ) ->
            String.fromChar (Char.toUpper first) ++ rest


clean4 : String -> String
clean4 =
    clean3 >> String.filter (Char.isDigit >> not)


clean : String -> String
clean =
    let
        notGreek c =
            Char.toCode c < Char.toCode 'α' || Char.toCode 'ω' < Char.toCode c
    in
    clean4 >> String.filter notGreek
