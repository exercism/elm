module BinarySearchTree exposing (BinaryTree(..), makeTree, sort)


type BinaryTree
    = Nil
    | Tree BinaryTree Int BinaryTree


makeTree : List Int -> BinaryTree
makeTree =
    Debug.todo "Please implement makeTree"


sort : List Int -> List Int
sort =
    Debug.todo "Please implement sort"
