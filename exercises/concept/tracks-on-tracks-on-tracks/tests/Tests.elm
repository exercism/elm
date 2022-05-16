module Tests exposing (tests)

import Expect
import List
import Test exposing (..)
import TracksOnTracksOnTracks exposing (..)


tests : Test
tests =
    describe "TracksOnTracksOnTracks"
        [ describe "1"
            [ test "newList should return an empty list" <|
                \_ ->
                    newList
                        |> Expect.equal []
            ]
        , describe "2"
            [ test "existingList should return Elm, Clojure and Haskell" <|
                \_ ->
                    existingList
                        |> Expect.equal [ "Elm", "Clojure", "Haskell" ]
            , test "addLanguage adds language to empty list" <|
                \_ ->
                    newList
                        |> addLanguage "Scala"
                        |> Expect.equal [ "Scala" ]
            , test "addLanguage adds language to existing list" <|
                \_ ->
                    existingList
                        |> addLanguage "Common Lisp"
                        |> Expect.equal [ "Common Lisp", "Elm", "Clojure", "Haskell" ]
            ]
        , describe "3"
            [ test "addLanguage adds language to custom list" <|
                \_ ->
                    addLanguage "Racket" [ "Scheme" ]
                        |> Expect.equal [ "Racket", "Scheme" ]
            ]
        , describe "4"
            [ test "Count languages on new list" <|
                \_ ->
                    newList
                        |> countLanguages
                        |> Expect.equal 0
            , test "Count languages on existing list" <|
                \_ ->
                    existingList
                        |> countLanguages
                        |> Expect.equal 3
            , test "Count languages on custom list" <|
                \_ ->
                    countLanguages [ "Python", "JavaScript" ]
                        |> Expect.equal 2
            ]
        , describe "5"
            [ test "Reverse order of new list" <|
                \_ ->
                    newList
                        |> reverseList
                        |> Expect.equal []
            , test "Reverse order of existing list" <|
                \_ ->
                    existingList
                        |> reverseList
                        |> Expect.equal (List.reverse existingList)
            , test "Reverse order of custom list" <|
                \_ ->
                    reverseList [ "Kotlin", "Java", "Scala", "Clojure" ]
                        |> Expect.equal [ "Clojure", "Scala", "Java", "Kotlin" ]
            ]
        , describe "6"
            [ test "Empty list is not exciting" <|
                \_ ->
                    excitingList []
                        |> Expect.equal False
            , test "Singleton list with Elm is exciting" <|
                \_ ->
                    excitingList [ "Elm" ]
                        |> Expect.equal True
            , test "Singleton list without Elm is not exciting" <|
                \_ ->
                    excitingList [ "C#" ]
                        |> Expect.equal False
            , test "Two-item list with Elm as first item is exciting" <|
                \_ ->
                    excitingList [ "Elm", "Clojure" ]
                        |> Expect.equal True
            , test "Two-item list with Elm as second item is exciting" <|
                \_ ->
                    excitingList [ "Nim", "Elm" ]
                        |> Expect.equal True
            , test "Two-item list without Elm is not exciting" <|
                \_ ->
                    excitingList [ "Python", "Go" ]
                        |> Expect.equal False
            , test "Three-item list with Elm as first item is exciting" <|
                \_ ->
                    excitingList [ "Elm", "Lisp", "Clojure" ]
                        |> Expect.equal True
            , test "Three-item list with Elm as second item is exciting" <|
                \_ ->
                    excitingList [ "Java", "Elm", "C#" ]
                        |> Expect.equal True
            , test "Three-item list with Elm as third item is not exciting" <|
                \_ ->
                    excitingList [ "Julia", "Assembly", "Elm" ]
                        |> Expect.equal False
            , test "Four-item list with Elm as first item is exciting" <|
                \_ ->
                    excitingList [ "Elm", "C", "C++", "C#" ]
                        |> Expect.equal True
            , test "Four-item list with Elm as second item is not exciting" <|
                \_ ->
                    excitingList [ "Erlang", "Elm", "C#", "Scheme" ]
                        |> Expect.equal False
            , test "Four-item list with Elm as third item is not exciting" <|
                \_ ->
                    excitingList [ "Erlang", "C#", "Elm", "Scheme" ]
                        |> Expect.equal False
            , test "Four-item list with Elm as fourth item is not exciting" <|
                \_ ->
                    excitingList [ "Erlang", "C#", "Scheme", "Elm" ]
                        |> Expect.equal False
            ]
        ]
