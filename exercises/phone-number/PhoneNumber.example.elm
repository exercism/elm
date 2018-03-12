module PhoneNumber exposing (getNumber, prettyPrint)

import List exposing (head, map)
import Maybe exposing (andThen)
import Regex exposing (HowMany(..), Regex, find, regex)
import String exposing (concat, length, slice, startsWith)


matchesFormat : Regex -> String -> Bool
matchesFormat regex string =
    case find (AtMost 1) regex string |> head of
        Just found ->
            True

        Nothing ->
            False


getNumber : String -> Maybe String
getNumber phoneNumber =
    let
        numberFormat =
            regex "^\\D*(\\+?1\\s*[\\-\\.]?\\s*)?((\\([2-9]\\d{2}\\))|([2-9]\\d{2}))\\s*[\\-\\.]?\\s*[2-9]\\d{2}\\s*[\\-\\.]?\\s*\\d{4}\\D*$"

        numbers =
            regex "\\d"

        dropCountryCode matchedNumbers =
            case matchedNumbers of
                "1" :: nums ->
                    nums

                _ ->
                    matchedNumbers

        stripNumber =
            concat << dropCountryCode << map .match << find All numbers
    in
    if phoneNumber |> matchesFormat numberFormat then
        Just <| stripNumber <| phoneNumber
    else
        Nothing


prettyPrint : String -> Maybe String
prettyPrint input =
    Maybe.map formatNumber (getNumber input)


formatNumber : String -> String
formatNumber input =
    String.concat
        [ "("
        , String.slice 0 3 input
        , ") "
        , String.slice 3 6 input
        , "-"
        , String.slice 6 10 input
        ]
