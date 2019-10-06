module HuffmanCode exposing (BinaryTree(..), binaryTree)

import Dict exposing (..)


type BinaryTree
    = Leaf Int Char
    | Node Int BinaryTree BinaryTree


binaryTree : String -> Maybe BinaryTree
binaryTree str =
    Debug.todo "Please implement this function"
