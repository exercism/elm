module HuffmanCode exposing (BinaryTree(..), binaryTree)

import Dict exposing (..)


type BinaryTree
    = Leaf Int Char
    | Node Int BinaryTree BinaryTree


binaryTree : String -> Maybe BinaryTree
binaryTree str =
    countChars str
        |> List.map (\( c, v ) -> Leaf v c)
        |> reduceBinaryTreeList
        |> List.head


countChars : String -> List ( Char, Int )
countChars str =
    let
        acc c dic =
            Dict.update c
                (\value ->
                    case value of
                        Just v ->
                            Just (v + 1)

                        Nothing ->
                            Just 1
                )
                dic
    in
    List.foldl acc Dict.empty (String.toList str)
        |> Dict.toList


reduceBinaryTreeList : List BinaryTree -> List BinaryTree
reduceBinaryTreeList lbt =
    case List.sortBy getValue lbt of
        h1 :: h2 :: tail2 ->
            reduceBinaryTreeList
                (Node (getValue h1 + getValue h2) h1 h2 :: tail2)

        _ ->
            lbt


getValue : BinaryTree -> Int
getValue bt =
    case bt of
        Leaf v _ ->
            v

        Node v _ _ ->
            v
