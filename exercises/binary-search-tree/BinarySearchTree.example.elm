module BinarySearchTree exposing (BinaryTree(..), binarySearchTree, sortedList)


type BinaryTree
    = EmptyNode
    | Node Int BinaryTree BinaryTree


binarySearchTree : List Int -> BinaryTree
binarySearchTree ints =
    List.foldl (\i acc -> add i acc) EmptyNode ints


add : Int -> BinaryTree -> BinaryTree
add i bt =
    case bt of
        EmptyNode ->
            Node i EmptyNode EmptyNode

        Node v left right ->
            if i <= v then
                Node v (add i left) right

            else
                Node v left (add i right)


sortedList : BinaryTree -> List Int
sortedList bt =
    case bt of
        EmptyNode ->
            []

        Node v left right ->
            sortedList left ++ (v :: sortedList right)
