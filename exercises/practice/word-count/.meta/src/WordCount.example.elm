module WordCount exposing (wordCount)

import Dict exposing (Dict)


sanitizeSentence : String -> String
sanitizeSentence sentence =
    String.toLower sentence
        |> String.map
            (\char ->
                if Char.isLower char || Char.isDigit char || char == '\'' then
                    char

                else
                    ' '
            )


sanitizeWord : String -> String
sanitizeWord word =
    if String.startsWith "'" word then
        sanitizeWord (String.dropLeft 1 word)

    else if String.endsWith "'" word then
        sanitizeWord (String.dropRight 1 word)

    else
        word


wordCount : String -> Dict String Int
wordCount sentence =
    sanitizeSentence sentence
        |> String.words
        |> List.map sanitizeWord
        |> List.foldl
            (\word dict ->
                Dict.update
                    word
                    (\count -> Maybe.withDefault 0 count + 1 |> Just)
                    dict
            )
            Dict.empty
        |> Dict.remove ""
