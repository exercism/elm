module Zipper exposing (..)


type BinTree a
    = Node (BinTree a) a (BinTree a)
    | Leaf


type Zipper a
    = TODO -- Please implement this type


fromTree : BinTree a -> Zipper a
fromTree =
    Debug.todo "Please implement this function"


toTree : Zipper a -> BinTree a
toTree =
    Debug.todo "Please implement this function"


left : Zipper a -> Maybe (Zipper a)
left =
    Debug.todo "Please implement this function"


right : Zipper a -> Maybe (Zipper a)
right =
    Debug.todo "Please implement this function"


up : Zipper a -> Maybe (Zipper a)
up =
    Debug.todo "Please implement this function"


setLeft : a -> Zipper a -> Zipper a
setLeft =
    Debug.todo "Please implement this function"


setRight : a -> Zipper a -> Zipper a
setRight =
    Debug.todo "Please implement this function"


setValue : a -> Zipper a -> Zipper a
setValue =
    Debug.todo "Please implement this function"


value : Zipper a -> a
value =
    Debug.todo "Please implement this function"
