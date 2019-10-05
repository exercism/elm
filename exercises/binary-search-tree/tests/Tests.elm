module Tests exposing (tests)

import BinarySearchTree exposing (BinaryTree(..), binarySearchTree, sortedList)
import Expect
import Test exposing (..)


tests : Test
tests =
    describe "binary-search-tree"
        [ test "Empty" <|
            \() ->
                Expect.equal EmptyNode (binarySearchTree [])
        , skip <|
            test "One Number" <|
                \() ->
                    Expect.equal (Node 4 EmptyNode EmptyNode) (binarySearchTree [ 4 ])
        , skip <|
            test "smaller number at left node" <|
                \() ->
                    Expect.equal (Node 4 (Node 2 EmptyNode EmptyNode) EmptyNode) (binarySearchTree [ 4, 2 ])
        , skip <|
            test "same number at left node" <|
                \() ->
                    Expect.equal (Node 4 (Node 4 EmptyNode EmptyNode) EmptyNode) (binarySearchTree [ 4, 4 ])
        , skip <|
            test "greater number at right node" <|
                \() ->
                    Expect.equal (Node 4 EmptyNode (Node 5 EmptyNode EmptyNode)) (binarySearchTree [ 4, 5 ])
        , skip <|
            test "can create complex tree" <|
                \() ->
                    Expect.equal
                        (Node 4
                            (Node 2
                                (Node 1 EmptyNode EmptyNode)
                                (Node 3 EmptyNode EmptyNode)
                            )
                            (Node 6 (Node 5 EmptyNode EmptyNode) (Node 7 EmptyNode EmptyNode))
                        )
                        (binarySearchTree [ 4, 2, 6, 1, 3, 5, 7 ])
        , skip <|
            test "can sort empty" <|
                \() ->
                    Expect.equal [] (sortedList (binarySearchTree []))
        , skip <|
            test "can sort single number" <|
                \() ->
                    Expect.equal [ 2 ] (sortedList (binarySearchTree [ 2 ]))
        , skip <|
            test "can sort if second number is smaller than first" <|
                \() ->
                    Expect.equal [ 1, 2 ] (sortedList (binarySearchTree [ 2, 1 ]))
        , skip <|
            test "can sort if second number is same as first" <|
                \() ->
                    Expect.equal [ 2, 2 ] (sortedList (binarySearchTree [ 2, 2 ]))
        , skip <|
            test "can sort if second number is greater than first" <|
                \() ->
                    Expect.equal [ 2, 3 ] (sortedList (binarySearchTree [ 2, 3 ]))
        , skip <|
            test "can sort complex tree" <|
                \() ->
                    Expect.equal [ 1, 2, 3, 5, 6, 7 ] (sortedList (binarySearchTree [ 2, 1, 3, 6, 7, 5 ]))
        ]
