module BinarySearchTree exposing (BinaryTree(..), makeTree, sort)


type BinaryTree
    = Empty
    | Tree BinaryTree Int BinaryTree


makeTree : List Int -> BinaryTree
makeTree =
    List.foldl insert Empty


sort : List Int -> List Int
sort =
    makeTree >> toList


insert : Int -> BinaryTree -> BinaryTree
insert n tree =
    case tree of
        Empty ->
            Tree Empty n Empty

        Tree left value right ->
            if n <= value then
                Tree (insert n left) value right

            else
                Tree left value (insert n right)


toList : BinaryTree -> List Int
toList tree =
    case tree of
        Empty ->
            []

        Tree left value right ->
            toList left ++ [ value ] ++ toList right
