module Tests exposing (tests)

import Expect
import Test exposing (..)
import Zipper
    exposing
        ( BinTree(..)
        , fromTree
        , left
        , right
        , setLeft
        , setRight
        , setValue
        , toTree
        , up
        , value
        )


t1 =
    Node (Node Leaf 2 (Node Leaf 3 Leaf)) 1 (Node Leaf 4 Leaf)


t2 =
    Node (Node Leaf 5 (Node Leaf 3 Leaf)) 1 (Node Leaf 4 Leaf)


t3 =
    Node (Node (Node Leaf 5 Leaf) 2 (Node Leaf 3 Leaf)) 1 (Node Leaf 4 Leaf)


t4 =
    Node (Node Leaf 2 Leaf) 1 (Node Leaf 4 Leaf)


t5 =
    Node (Node Leaf 7 Leaf) 6 (Node Leaf 8 Leaf)


t6 =
    Node (Node Leaf 2 (Node Leaf 3 Leaf)) 1 (Node (Node Leaf 7 Leaf) 6 (Node Leaf 8 Leaf))


t7 =
    Node (Node Leaf 2 (Node Leaf 5 Leaf)) 1 (Node Leaf 4 Leaf)


tests : Test
tests =
    describe "Zipper"
        [ test "data is retainer" <|
            \_ ->
                t1
                    |> fromTree
                    |> Maybe.map toTree
                    |> Expect.equal (Just t1)
        , test "left, right and value" <|
            \_ ->
                t1
                    |> fromTree
                    |> Maybe.andThen left
                    |> Maybe.andThen right
                    |> Maybe.map value
                    |> Expect.equal (Just 3)
        , test "dead end" <|
            \_ ->
                t1
                    |> fromTree
                    |> Maybe.andThen left
                    |> Maybe.andThen left
                    |> Expect.equal Nothing
        , test "traversing up from top" <|
            \_ ->
                t1
                    |> fromTree
                    |> Maybe.andThen up
                    |> Expect.equal Nothing
        , test "left, right, and up" <|
            \_ ->
                t1
                    |> fromTree
                    |> Maybe.andThen left
                    |> Maybe.andThen up
                    |> Maybe.andThen right
                    |> Maybe.andThen up
                    |> Maybe.andThen left
                    |> Maybe.andThen right
                    |> Maybe.map value
                    |> Expect.equal (Just 3)
        , test "tree from deep focus" <|
            \_ ->
                t1
                    |> fromTree
                    |> Maybe.andThen left
                    |> Maybe.andThen right
                    |> Maybe.map toTree
                    |> Expect.equal (Just t1)
        , test "setValue" <|
            \_ ->
                t1
                    |> fromTree
                    |> Maybe.andThen left
                    |> Maybe.map (setValue 5)
                    |> Maybe.map toTree
                    |> Expect.equal (Just t2)
        , test "setValue after traversing up" <|
            \_ ->
                t1
                    |> fromTree
                    |> Maybe.andThen left
                    |> Maybe.andThen right
                    |> Maybe.andThen up
                    |> Maybe.map (setValue 5)
                    |> Maybe.map toTree
                    |> Expect.equal (Just t2)
        , test "setLeft with Just" <|
            \_ ->
                t1
                    |> fromTree
                    |> Maybe.andThen left
                    |> Maybe.map (setLeft (Node Leaf 5 Leaf))
                    |> Maybe.map toTree
                    |> Expect.equal (Just t3)
        , test "setRight with Nothing" <|
            \_ ->
                t1
                    |> fromTree
                    |> Maybe.andThen left
                    |> Maybe.map (setRight Leaf)
                    |> Maybe.map toTree
                    |> Expect.equal (Just t4)
        , test "setRight with subtree" <|
            \_ ->
                t1
                    |> fromTree
                    |> Maybe.map (setRight t5)
                    |> Maybe.map toTree
                    |> Expect.equal (Just t6)
        , test "setValue on deep focus" <|
            \_ ->
                t1
                    |> fromTree
                    |> Maybe.andThen left
                    |> Maybe.andThen right
                    |> Maybe.map (setValue 5)
                    |> Maybe.map toTree
                    |> Expect.equal (Just t7)
        , test "different paths to same zipper" <|
            \_ ->
                let
                    path1 =
                        t1
                            |> fromTree
                            |> Maybe.andThen left
                            |> Maybe.andThen up
                            |> Maybe.andThen right

                    path2 =
                        t1
                            |> fromTree
                            |> Maybe.andThen right
                in
                    Expect.equal path2 path1
        ]
