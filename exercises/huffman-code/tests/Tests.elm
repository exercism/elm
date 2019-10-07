module Tests exposing (tests)

import Expect
import HuffmanCode exposing (BinaryTree(..), binaryTree)
import Test exposing (..)


score : Maybe BinaryTree -> Int -> Int
score mbt deep =
    case mbt of
        Nothing ->
            0

        Just (Leaf v _) ->
            deep * v

        Just (Node v bt1 bt2) ->
            score (Just bt1) (deep + 1) + score (Just bt2) (deep + 1)


tests : Test
tests =
    describe "huffman-code"
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
            test "a first test based on wikipedia v2" <|
                \() ->
                    Expect.atMost
                        87
                        (score (binaryTree "aaaaaaaaaaaaaaabbbbbbbccccccddddddeeeee") 0)
        , skip <|
            test "a long sentence" <|
                \() ->
                    Expect.atMost
                        135
                        (score (binaryTree "this is an example of a huffman tree") 0)
        ]
