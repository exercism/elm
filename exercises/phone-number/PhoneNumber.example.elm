module PhoneNumber exposing (..)

import Regex exposing (Regex, regex, find, HowMany(..))
import String exposing (concat, startsWith, length, slice)
import List exposing (map, head)
import Maybe exposing (andThen)


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
            regex "^\\D*(\\+?1[\\-\\s\\.]?)?((\\([2-9]\\d{2}\\))|([2-9]\\d{2}))[\\-\\s\\.]?[2-9]\\d{2}[\\-\\s\\.]?\\d{4}\\D*$"

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
prettyPrint phoneNumber =
    let
        numberFormat =
            regex "^1?[2-9]\\d{2}[2-9]\\d{2}\\d{4}$"

        prettyNumber =
            if phoneNumber |> startsWith "1" then
                "(" ++ (slice 1 4 phoneNumber) ++ ") " ++ (slice 4 7 phoneNumber) ++ "-" ++ (slice 7 11 phoneNumber)
            else
                "(" ++ (slice 0 3 phoneNumber) ++ ") " ++ (slice 3 6 phoneNumber) ++ "-" ++ (slice 6 10 phoneNumber)
    in
        if phoneNumber |> matchesFormat numberFormat then
            Just prettyNumber
        else
            Nothing
