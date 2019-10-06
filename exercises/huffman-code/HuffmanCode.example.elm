module HuffmanCode exposing (BinaryTree(..), binaryTree)

import Dict exposing (..)


type BinaryTree
    = Leaf Int Char
    | Node Int BinaryTree BinaryTree


binaryTree : String -> Maybe BinaryTree
binaryTree str =
    List.foldl updateDicoAcc Dict.empty (String.toList str)
        |> Dict.toList
        |> List.map (\( c, v ) -> Leaf v c)
        |> recursiveReduceBinaryTreeList
        |> List.head


recursiveReduceBinaryTreeList : List BinaryTree -> List BinaryTree
recursiveReduceBinaryTreeList lbt =
    case List.sortBy (\n -> getValue n) lbt of
        [] ->
            []

        h1 :: tail1 ->
            case tail1 of
                [] ->
                    [ h1 ]

                h2 :: tail2 ->
                    recursiveReduceBinaryTreeList
                        (Node (getValue h1 + getValue h2) h1 h2 :: tail2)


getValue : BinaryTree -> Int
getValue bt =
    case bt of
        Leaf v _ ->
            v

        Node v _ _ ->
            v


updateDicoAcc : Char -> Dict Char Int -> Dict Char Int
updateDicoAcc c dico =
    Dict.update c
        (\value ->
            case value of
                Just v ->
                    Just (v + 1)

                Nothing ->
                    Just 1
        )
        dico
