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
                    |> Expect.equal (Tree Empty 4 Empty)
        , describe "insert data at proper node"
            [ skip <|
                test "smaller number at left node" <|
                    \() ->
                        BinarySearchTree.makeTree [ 4, 2 ]
                            |> Expect.equal (Tree (Tree Empty 2 Empty) 4 Empty)
            , skip <|
                test "same number at left node" <|
                    \() ->
                        BinarySearchTree.makeTree [ 4, 4 ]
                            |> Expect.equal (Tree (Tree Empty 4 Empty) 4 Empty)
            , skip <|
                test "greater number at right node" <|
                    \() ->
                        BinarySearchTree.makeTree [ 4, 5 ]
                            |> Expect.equal (Tree Empty 4 (Tree Empty 5 Empty))
            ]
        , skip <|
            test "can create complex tree" <|
                \() ->
                    BinarySearchTree.makeTree [ 4, 2, 6, 1, 3, 5, 7 ]
                        |> Expect.equal (Tree (Tree (Tree Empty 1 Empty) 2 (Tree Empty 3 Empty)) 4 (Tree (Tree Empty 5 Empty) 6 (Tree Empty 7 Empty)))
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
