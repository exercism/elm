module Transpose exposing (transpose)

import List
import String


transpose : List String -> List String
transpose lines =
    let
        longestRow =
            Maybe.withDefault 0 <|
                List.maximum <|
                    List.map String.length lines

        padNothingRight maxLength line =
            line ++ List.repeat (maxLength - List.length line) Nothing

        stringify line =
            String.concat <|
                List.map
                    (\x ->
                        case x of
                            Nothing ->
                                " "

                            Just c ->
                                String.fromChar c
                    )
                    (dropNothingRight line)

        dropNothingRight line =
            Tuple.second <|
                List.foldr
                    (\x ( ignore, list ) ->
                        if ignore && x == Nothing then
                            ( ignore, list )
                        else
                            ( False, x :: list )
                    )
                    ( True, [] )
                    line
    in
    List.map stringify <|
        List.foldr
            (List.map2 (::))
            (List.repeat longestRow [])
            (List.map (padNothingRight longestRow << List.map Just << String.toList) lines)
