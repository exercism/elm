module PigLatin exposing (translate)


translate : String -> String
translate =
    String.words >> List.map translateWord >> String.join " "


translateWord : String -> String
translateWord input =
    if String.startsWith "xr" input || String.startsWith "yt" input then
        input ++ "ay"

    else if String.startsWith "y" input then
        String.dropLeft 1 input ++ "yay"

    else
        let
            ( consonnants, rest ) =
                splitConsonant input
        in
        if String.endsWith "q" consonnants && String.startsWith "u" rest then
            String.dropLeft 1 rest ++ consonnants ++ "uay"

        else
            rest ++ consonnants ++ "ay"


splitConsonant : String -> ( String, String )
splitConsonant input =
    let
        isVowelOrY char =
            List.member char [ 'a', 'e', 'i', 'o', 'u', 'y' ]

        ( first, second ) =
            input |> String.toList |> takeWhile (isVowelOrY >> not)
    in
    ( String.fromList first, String.fromList second )


takeWhile : (a -> Bool) -> List a -> ( List a, List a )
takeWhile condition list =
    case list of
        [] ->
            ( [], [] )

        head :: tail ->
            if condition head then
                let
                    ( first, second ) =
                        takeWhile condition tail
                in
                ( head :: first, second )

            else
                ( [], list )
