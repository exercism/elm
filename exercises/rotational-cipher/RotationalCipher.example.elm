module RotationalCipher exposing (rotate)

import Char exposing (isUpper, isLower, toLower, toCode, fromCode)
import String
import Dict exposing (Dict)


isAlpha : Char -> Bool
isAlpha char =
    isUpper char || isLower char


splitAt : Int -> List a -> ( List a, List a )
splitAt n xs =
    ( List.take n xs, List.drop n xs )


setDict : List Int -> Int -> Dict Char Char -> Dict Char Char
setDict range key dict =
    let
        r =
            List.map (\k -> fromCode k) range

        ( a, b ) =
            splitAt key r

        zipped =
            List.map2 (,) r (b ++ a)
    in
        Dict.union dict (Dict.fromList zipped)


rotate : String -> Int -> String
rotate phrase by =
    let
        lowerCase =
            List.range (toCode 'a') (toCode 'z')

        upperCase =
            List.range (toCode 'A') (toCode 'Z')

        dict =
            Dict.empty |> setDict lowerCase by |> setDict upperCase by

        getKey c =
            case Dict.get c dict of
                Nothing ->
                    c

                Just r ->
                    r
    in
        phrase |> String.map getKey
