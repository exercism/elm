module PhoneNumber exposing (getNumber, prettyPrint)

import List exposing (head, map)
import Maybe exposing (andThen)
import Regex exposing (Regex)
import String exposing (concat, length, slice, startsWith)


matchesFormat : Regex -> String -> Bool
matchesFormat regex string =
    case Regex.find regex string of
        [] ->
            False

        _ ->
            True


getNumber : String -> Maybe String
getNumber phoneNumber =
    let
        regex string =
            Maybe.withDefault Regex.never <| Regex.fromString string

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
            concat << dropCountryCode << map .match << findAll numbers

        findAll xs =
            Regex.find xs
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
