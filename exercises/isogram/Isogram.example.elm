module Isogram exposing (isIsogram)

import Char
import List
import String


isAlpha : Char -> Bool
isAlpha char =
    Char.isUpper char || Char.isLower char


isIsogram : String -> Bool
isIsogram sentence =
    let
        sanitized =
            String.filter isAlpha sentence
                |> String.toLower
                |> String.toList
                |> List.sort
                |> group
    in
    List.all (\x -> List.length x == 1) sanitized



-- Adapted from https://github.com/elm-community/list-extra


group : List a -> List (List a)
group list =
    case list of
        [] ->
            []

        x :: xs ->
            let
                ( ys, zs ) =
                    span ((==) x) xs
            in
            (x :: ys) :: group zs


span : (a -> Bool) -> List a -> ( List a, List a )
span p xs =
    ( takeWhile p xs, dropWhile p xs )


takeWhile : (a -> Bool) -> List a -> List a
takeWhile predicate =
    let
        takeWhileHelper acc list =
            case list of
                [] ->
                    List.reverse acc

                x :: xs ->
                    if predicate x then
                        takeWhileHelper (x :: acc) xs
                    else
                        List.reverse acc
    in
    takeWhileHelper []


dropWhile : (a -> Bool) -> List a -> List a
dropWhile predicate list =
    case list of
        [] ->
            []

        x :: xs ->
            if predicate x then
                dropWhile predicate xs
            else
                list
