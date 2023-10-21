module BinarySearchTree exposing (BinaryTree(..), makeTree, sort)


type BinaryTree
    = Empty
    | Tree BinaryTree Int BinaryTree


makeTree : List Int -> BinaryTree
makeTree data =
    Debug.todo "Please implement makeTree"


sort : List Int -> List Int
sort data =
    Debug.todo "Please implement sort"
