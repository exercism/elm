module Zipper
    exposing
        ( BinTree(..)
        , Zipper
        , fromTree
        , toTree
        , value
        , left
        , right
        , up
        , setValue
        , setLeft
        , setRight
        )

{-| A binary tree.
-}


type BinTree a
    = Node (BinTree a) a (BinTree a)
    | Leaf


{-| A zipper for a binary tree.
-}
type Zipper a
    = Zipper
        { value : a -- Value of focus
        , left : BinTree a -- Left child of focus
        , right : BinTree a -- Right child of focus
        , trail : ZipperTrail a -- Zipper trail, field name not use
        }


{-| A "trail" of a zipper.

This stores the history of how the focus was reached
and the value and other paths higher up in the tree.

-}
type ZipperTrail a
    = Left a (BinTree a) (ZipperTrail a) -- Left path taken
    | Right a (BinTree a) (ZipperTrail a) -- Right path taken
    | Top -- Top level


{-| Get a zipper focussed on the root node.
-}
fromTree : BinTree a -> Maybe (Zipper a)
fromTree tree =
    case tree of
        Node leftTree val rightTree ->
            Just
                (Zipper
                    { value = val
                    , left = leftTree
                    , right = rightTree
                    , trail = Top
                    }
                )

        Leaf ->
            Nothing


{-| Get the complete tree from a zipper.
-}
toTree : Zipper a -> BinTree a
toTree (Zipper zip) =
    let
        go : BinTree a -> ZipperTrail a -> BinTree a
        go tree trail =
            case trail of
                Left trailVal treeRight newTrail ->
                    go (Node tree trailVal treeRight) newTrail

                Right trailVal treeLeft newTrail ->
                    go (Node treeLeft trailVal tree) newTrail

                Top ->
                    tree
    in
        go (Node zip.left zip.value zip.right) zip.trail


{-| Get the value of the focus node.
-}
value : Zipper a -> a
value (Zipper z) =
    z.value


{-| Get the left child of the focus node, if any.
-}
left : Zipper a -> Maybe (Zipper a)
left (Zipper zip) =
    case zip.left of
        Leaf ->
            Nothing

        Node treeLeft treeVal treeRight ->
            Just
                (Zipper
                    { value = treeVal
                    , left = treeLeft
                    , right = treeRight
                    , trail = Left zip.value zip.right zip.trail
                    }
                )


{-| Get the right child of the focus node, if any.
-}
right : Zipper a -> Maybe (Zipper a)
right (Zipper zip) =
    case zip.right of
        Leaf ->
            Nothing

        Node leftTree treeVal rightTree ->
            Just
                (Zipper
                    { value = treeVal
                    , left = leftTree
                    , right = rightTree
                    , trail = Right zip.value zip.left zip.trail
                    }
                )


{-| Get the parent of the focus node, if any.
-}
up : Zipper a -> Maybe (Zipper a)
up (Zipper zip) =
    case zip.trail of
        Left pv pr zt ->
            Just
                (Zipper
                    { value = pv
                    , left = Node zip.left zip.value zip.right
                    , right = pr
                    , trail = zt
                    }
                )

        Right pv pl zt ->
            Just
                (Zipper
                    { value = pv
                    , left = pl
                    , right = Node zip.left zip.value zip.right
                    , trail = zt
                    }
                )

        Top ->
            Nothing


{-| Set the value of the focus node.
-}
setValue : a -> Zipper a -> Zipper a
setValue v (Zipper z) =
    Zipper { z | value = v }


{-| Replace a left child tree.
-}
setLeft : BinTree a -> Zipper a -> Zipper a
setLeft t (Zipper z) =
    Zipper { z | left = t }


{-| Replace a right child tree.
-}
setRight : BinTree a -> Zipper a -> Zipper a
setRight t (Zipper z) =
    Zipper { z | right = t }
