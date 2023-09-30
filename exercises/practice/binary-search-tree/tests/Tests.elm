module Tests exposing (tests)

import BinarySearchTree exposing (BinaryTree(..))
import Expect
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "BinarySearchTree"
        [ test "data is retained" <|
            \() ->
                BinarySearchTree.makeTree [ 4 ]
                    |> Expect.equal (Tree Nil 4 Nil)
        , describe "insert data at proper node"
            [ skip <|
                test "smaller number at left node" <|
                    \() ->
                        BinarySearchTree.makeTree [ 4, 2 ]
                            |> Expect.equal (Tree (Tree Nil 2 Nil) 4 Nil)
            , skip <|
                test "same number at left node" <|
                    \() ->
                        BinarySearchTree.makeTree [ 4, 4 ]
                            |> Expect.equal (Tree (Tree Nil 4 Nil) 4 Nil)
            , skip <|
                test "greater number at right node" <|
                    \() ->
                        BinarySearchTree.makeTree [ 4, 5 ]
                            |> Expect.equal (Tree Nil 4 (Tree Nil 5 Nil))
            ]
        , skip <|
            test "can create complex tree" <|
                \() ->
                    BinarySearchTree.makeTree [ 4, 2, 6, 1, 3, 5, 7 ]
                        |> Expect.equal (Tree (Tree (Tree Nil 1 Nil) 2 (Tree Nil 3 Nil)) 4 (Tree (Tree Nil 5 Nil) 6 (Tree Nil 7 Nil)))
        , describe "can sort data"
            [ skip <|
                test "can sort single number" <|
                    \() ->
                        BinarySearchTree.sort [ 2 ]
                            |> Expect.equal [ 2 ]
            , skip <|
                test "can sort if second number is smaller than first" <|
                    \() ->
                        BinarySearchTree.sort [ 2, 1 ]
                            |> Expect.equal [ 1, 2 ]
            , skip <|
                test "can sort if second number is same as first" <|
                    \() ->
                        BinarySearchTree.sort [ 2, 2 ]
                            |> Expect.equal [ 2, 2 ]
            , skip <|
                test "can sort if second number is greater than first" <|
                    \() ->
                        BinarySearchTree.sort [ 2, 3 ]
                            |> Expect.equal [ 2, 3 ]
            , skip <|
                test "can sort complex tree" <|
                    \() ->
                        BinarySearchTree.sort [ 2, 1, 3, 6, 7, 5 ]
                            |> Expect.equal [ 1, 2, 3, 5, 6, 7 ]
            ]
        ]
