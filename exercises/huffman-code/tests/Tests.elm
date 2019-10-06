module Tests exposing (tests)

import Expect
import HuffmanCode exposing (BinaryTree(..), binaryTree)
import Test exposing (..)


tests : Test
tests =
    describe "Huffman-code"
        [ test "Empty" <|
            \() ->
                Expect.equal Nothing (binaryTree "")
        , skip <|
            test "One char" <|
                \() ->
                    Expect.equal (Just (Leaf 1 '1'))
                        (binaryTree "1")
        , skip <|
            test "2 chars" <|
                \() ->
                    Expect.equal (Just (Node 2 (Leaf 1 '1') (Leaf 1 '2')))
                        (binaryTree "12")
        , skip <|
            test "2 char identical" <|
                \() ->
                    Expect.equal (Just (Leaf 2 '1'))
                        (binaryTree "11")
        , skip <|
            test "a first test based on wikipedia" <|
                \() ->
                    Expect.equal
                        (Just
                            (Node 39
                                (Leaf 15 'a')
                                (Node 24
                                    (Node 11 (Leaf 5 'e') (Leaf 6 'c'))
                                    (Node 13 (Leaf 6 'd') (Leaf 7 'b'))
                                )
                            )
                        )
                        (binaryTree "aaaaaaaaaaaaaaabbbbbbbccccccddddddeeeee")
        , skip <|
            test "a long sentence" <|
                \() ->
                    Expect.equal
                        (Just
                            (Node 36
                                (Node 16
                                    (Node 8 (Leaf 4 'a') (Leaf 4 'e'))
                                    (Node 8
                                        (Node 4
                                            (Node 2 (Leaf 1 'l') (Leaf 1 'o'))
                                            (Leaf 2 'h')
                                        )
                                        (Node 4
                                            (Node 2 (Leaf 1 'u') (Leaf 1 'x'))
                                            (Node 2 (Leaf 1 'p') (Leaf 1 'r'))
                                        )
                                    )
                                )
                                (Node 20
                                    (Node 8
                                        (Node 4 (Leaf 2 'n') (Leaf 2 's'))
                                        (Node 4 (Leaf 2 'i') (Leaf 2 'm'))
                                    )
                                    (Node 12
                                        (Node 5 (Leaf 2 't') (Leaf 3 'f'))
                                        (Leaf 7 ' ')
                                    )
                                )
                            )
                        )
                        (binaryTree "this is an example of a huffman tree")
        ]
