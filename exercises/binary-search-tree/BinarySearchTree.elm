module BinarySearchTree exposing (BinaryTree(..), binarySearchTree, sortedList)


type BinaryTree
    = EmptyNode
    | Node Int BinaryTree BinaryTree


binarySearchTree : List Int -> BinaryTree
binarySearchTree ints =
    Debug.todo "Please implement this function"


sortedList : BinaryTree -> List Int
sortedList bt =
    Debug.todo "Please implement this function"
