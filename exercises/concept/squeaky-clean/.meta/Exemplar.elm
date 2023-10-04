module SquakyClean exposing (clean1, clean2, clean3, clean4, clean5)


clean1 : String -> String
clean1 str =
    String.replace " " "_" str


clean2 : String -> String
clean2 str =
    let
        isCtrl : String -> Bool
        isCtrl s =
            List.member s [ "\n", "\t", "\u{000D}", "\u{0000}" ]
    in
    String.split "" str
        |> List.map
            (\s ->
                if isCtrl s then
                    "[CTRL]"

                else
                    s
            )
        |> String.concat
        |> clean1


clean3 : String -> String
clean3 str =
    let
        charWordPairs : List (Maybe ( Char, String ))
        charWordPairs =
            String.split "-" str
                |> List.map String.uncons

        capitalizedWords : String
        capitalizedWords =
            case charWordPairs of
                wrd1 :: rest ->
                    List.map
                        (Maybe.map
                            (\( c, restOfStr ) ->
                                ( Char.toUpper c, restOfStr )
                            )
                        )
                        rest
                        |> List.map
                            (Maybe.map
                                (\( c, restOfStr ) ->
                                    String.cons c restOfStr
                                )
                            )
                        |> List.foldr
                            (\wrd ->
                                (++) (Maybe.withDefault "" wrd)
                            )
                            ""
                        |> (\wrds ->
                                Maybe.map
                                    (\( c, restOfStr ) ->
                                        String.cons c restOfStr
                                    )
                                    wrd1
                                    |> Maybe.withDefault ""
                                    |> (\wrd -> wrd ++ wrds)
                           )

                _ ->
                    ""
    in
    capitalizedWords
        |> clean2


clean4 : String -> String
clean4 str =
    str
        |> String.filter (\c -> not (Char.isDigit c))
        |> clean3


clean5 : String -> String
clean5 str =
    let
        emoticons : List Char
        emoticons =
            List.map Char.fromCode <| List.range 128512 128591

        greekLCase : List Char
        greekLCase =
            List.map Char.fromCode <| List.range 945 969

        notGreekLCaseOrEmo : Char -> Bool
        notGreekLCaseOrEmo c =
            not <| List.member c (emoticons ++ greekLCase)
    in
    String.filter notGreekLCaseOrEmo str
        |> clean4
