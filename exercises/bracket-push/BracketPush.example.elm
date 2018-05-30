module BracketPush exposing (isPaired)

import Dict exposing (Dict)
import List
import String


isPaired : String -> Bool
isPaired input =
    let
        onlyBrackets =
            String.filter (flip List.member bracketList)

        tryMatching bracket visited =
            case visited of
                [] ->
                    bracket :: visited

                top :: visited ->
                    if isPairMatch top bracket then
                        visited
                    else
                        bracket :: top :: visited

        isPairMatch prev current =
            case Dict.get prev bracketDict of
                Nothing ->
                    False

                Just rightBracket ->
                    current == rightBracket
    in
    input
        |> onlyBrackets
        |> String.foldl tryMatching []
        |> List.isEmpty


bracketList : List Char
bracketList =
    [ '{', '}', '[', ']', '(', ')' ]


bracketDict : Dict Char Char
bracketDict =
    Dict.fromList
        [ ( '{', '}' )
        , ( '[', ']' )
        , ( '(', ')' )
        ]
