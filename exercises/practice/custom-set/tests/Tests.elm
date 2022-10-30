module Tests exposing (tests)

import CustomSet
import Expect
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "CustomSet"
        [ describe "Unique elements can be added to a set"
            [ -- skip <|
              test "add to empty set" <|
                \() ->
                    CustomSet.insert 3 CustomSet.empty
                        |> CustomSet.toList
                        |> List.sort
                        |> Expect.equalLists [ 3 ]
            , skip <|
                test "add to non-empty set" <|
                    \() ->
                        CustomSet.insert 3 (CustomSet.fromList [ 1, 2, 4 ])
                            |> CustomSet.toList
                            |> List.sort
                            |> Expect.equalLists [ 1, 2, 3, 4 ]
            , skip <|
                test "adding an existing element does not change the set" <|
                    \() ->
                        CustomSet.insert 3 (CustomSet.fromList [ 1, 2, 3 ])
                            |> CustomSet.toList
                            |> List.sort
                            |> Expect.equalLists [ 1, 2, 3 ]
            ]
        , describe "Returns true if the set contains no elements"
            [ skip <|
                test "empty set is empty" <|
                    \() ->
                        CustomSet.isEmpty CustomSet.empty
                            |> Expect.true "isEmpty empty should be True"
            , skip <|
                test "sets with no elements are empty" <|
                    \() ->
                        CustomSet.isEmpty (CustomSet.fromList [])
                            |> Expect.true "isEmpty (fromList []) should be True"
            , skip <|
                test "sets with elements are not empty" <|
                    \() ->
                        CustomSet.isEmpty (CustomSet.fromList [ 1 ])
                            |> Expect.false "isEmpty (fromList [ 1 ]) should be False"
            ]
        , describe "Sets can report if they contain an element"
            [ skip <|
                test "nothing is contained in an empty set" <|
                    \() ->
                        CustomSet.member 1 CustomSet.empty
                            |> Expect.false "member 1 empty should be False"
            , skip <|
                test "when the element is in the set" <|
                    \() ->
                        CustomSet.member 1 (CustomSet.fromList [ 1, 2, 3 ])
                            |> Expect.true "member 1 (fromList [ 1, 2, 3 ]) should be True"
            , skip <|
                test "when the element is not in the set" <|
                    \() ->
                        CustomSet.member 4 (CustomSet.fromList [ 1, 2, 3 ])
                            |> Expect.false "member 4 (fromList [ 1, 2, 3 ]) should be False"
            ]
        , describe "Sets with the same elements are equal"
            [ skip <|
                test "empty sets are equal" <|
                    \() ->
                        CustomSet.equal CustomSet.empty CustomSet.empty
                            |> Expect.true "equal empty empty should be True"
            , skip <|
                test "empty set is not equal to non-empty set" <|
                    \() ->
                        CustomSet.equal CustomSet.empty (CustomSet.fromList [ 1, 2, 3 ])
                            |> Expect.false "equal empty (fromList [ 1, 2, 3 ]) should be False"
            , skip <|
                test "non-empty set is not equal to empty set" <|
                    \() ->
                        CustomSet.equal (CustomSet.fromList [ 1, 2, 3 ]) CustomSet.empty
                            |> Expect.false "equal (fromList [ 1, 2, 3 ]) empty should be False"
            , skip <|
                test "sets with the same elements are equal" <|
                    \() ->
                        CustomSet.equal (CustomSet.fromList [ 1, 2 ]) (CustomSet.fromList [ 2, 1 ])
                            |> Expect.true "equal (fromList [ 1, 2 ]) (fromList [ 2, 1 ]) should be True"
            , skip <|
                test "sets with different elements are not equal" <|
                    \() ->
                        CustomSet.equal (CustomSet.fromList [ 1, 2, 3 ]) (CustomSet.fromList [ 1, 2, 4 ])
                            |> Expect.false "equal (fromList [ 1, 2, 3 ]) (fromList [ 1, 2, 4 ]) should be False"
            , skip <|
                test "set is not equal to larger set with same elements" <|
                    \() ->
                        CustomSet.equal (CustomSet.fromList [ 1, 2, 3 ]) (CustomSet.fromList [ 1, 2, 3, 4 ])
                            |> Expect.false "equal (fromList [ 1, 2, 3 ]) (fromList [ 1, 2, 3, 4 ]) should be False"
            ]
        , describe "Union returns a set of all elements in either set"
            [ skip <|
                test "union of empty sets is an empty set" <|
                    \() ->
                        CustomSet.union CustomSet.empty CustomSet.empty
                            |> CustomSet.toList
                            |> List.sort
                            |> Expect.equalLists []
            , skip <|
                test "union of an empty set and non-empty set is the non-empty set" <|
                    \() ->
                        CustomSet.union CustomSet.empty (CustomSet.fromList [ 2 ])
                            |> CustomSet.toList
                            |> List.sort
                            |> Expect.equalLists [ 2 ]
            , skip <|
                test "union of a non-empty set and empty set is the non-empty set" <|
                    \() ->
                        CustomSet.union (CustomSet.fromList [ 1, 3 ]) CustomSet.empty
                            |> CustomSet.toList
                            |> List.sort
                            |> Expect.equalLists [ 1, 3 ]
            , skip <|
                test "union of non-empty sets contains all unique elements" <|
                    \() ->
                        CustomSet.union (CustomSet.fromList [ 1, 3 ]) (CustomSet.fromList [ 2, 3 ])
                            |> CustomSet.toList
                            |> List.sort
                            |> Expect.equalLists [ 1, 2, 3 ]
            ]
        , describe "Intersection returns a set of all shared elements"
            [ skip <|
                test "intersection of two empty sets is an empty set" <|
                    \() ->
                        CustomSet.intersect CustomSet.empty CustomSet.empty
                            |> CustomSet.toList
                            |> List.sort
                            |> Expect.equalLists []
            , skip <|
                test "intersection of an empty set and non-empty set is an empty set" <|
                    \() ->
                        CustomSet.intersect CustomSet.empty (CustomSet.fromList [ 3, 2, 5 ])
                            |> CustomSet.toList
                            |> List.sort
                            |> Expect.equalLists []
            , skip <|
                test "intersection of a non-empty set and an empty set is an empty set" <|
                    \() ->
                        CustomSet.intersect (CustomSet.fromList [ 1, 2, 3, 4 ]) CustomSet.empty
                            |> CustomSet.toList
                            |> List.sort
                            |> Expect.equalLists []
            , skip <|
                test "intersection of two sets with no shared elements is an empty set" <|
                    \() ->
                        CustomSet.intersect (CustomSet.fromList [ 1, 2, 3 ]) (CustomSet.fromList [ 4, 5, 6 ])
                            |> CustomSet.toList
                            |> List.sort
                            |> Expect.equalLists []
            , skip <|
                test "intersection of two sets with shared elements is a set of the shared elements" <|
                    \() ->
                        CustomSet.intersect (CustomSet.fromList [ 1, 2, 3, 4 ]) (CustomSet.fromList [ 3, 2, 5 ])
                            |> CustomSet.toList
                            |> List.sort
                            |> Expect.equalLists [ 2, 3 ]
            ]
        , describe "Difference (or Complement) of a set is a set of all elements that are only in the first set"
            [ skip <|
                test "difference of two empty sets is an empty set" <|
                    \() ->
                        CustomSet.diff CustomSet.empty CustomSet.empty
                            |> CustomSet.toList
                            |> List.sort
                            |> Expect.equalLists []
            , skip <|
                test "difference of empty set and non-empty set is an empty set" <|
                    \() ->
                        CustomSet.diff CustomSet.empty (CustomSet.fromList [ 3, 2, 5 ])
                            |> CustomSet.toList
                            |> List.sort
                            |> Expect.equalLists []
            , skip <|
                test "difference of a non-empty set and an empty set is the non-empty set" <|
                    \() ->
                        CustomSet.diff (CustomSet.fromList [ 1, 2, 3, 4 ]) CustomSet.empty
                            |> CustomSet.toList
                            |> List.sort
                            |> Expect.equalLists [ 1, 2, 3, 4 ]
            , skip <|
                test "difference of two non-empty sets is a set of elements that are only in the first set" <|
                    \() ->
                        CustomSet.diff (CustomSet.fromList [ 3, 2, 1 ]) (CustomSet.fromList [ 2, 4 ])
                            |> CustomSet.toList
                            |> List.sort
                            |> Expect.equalLists [ 1, 3 ]
            ]
        , describe "A set is a subset if all of its elements are contained in the other set"
            [ skip <|
                test "empty set is a subset of another empty set" <|
                    \() ->
                        CustomSet.subset CustomSet.empty CustomSet.empty
                            |> Expect.true "subset empty empty should be True"
            , skip <|
                test "empty set is a subset of non-empty set" <|
                    \() ->
                        CustomSet.subset CustomSet.empty (CustomSet.fromList [ 1 ])
                            |> Expect.true "subset empty (fromList [ 1 ]) should be True"
            , skip <|
                test "non-empty set is not a subset of empty set" <|
                    \() ->
                        CustomSet.subset (CustomSet.fromList [ 1 ]) CustomSet.empty
                            |> Expect.false "subset (fromList [ 1 ]) empty should be False"
            , skip <|
                test "set is a subset of set with exact same elements" <|
                    \() ->
                        CustomSet.subset (CustomSet.fromList [ 1, 2, 3 ]) (CustomSet.fromList [ 1, 2, 3 ])
                            |> Expect.true "subset (fromList [ 1, 2, 3 ]) (fromList [ 1, 2, 3 ]) should be True"
            , skip <|
                test "set is a subset of larger set with same elements" <|
                    \() ->
                        CustomSet.subset (CustomSet.fromList [ 1, 2, 3 ]) (CustomSet.fromList [ 4, 1, 2, 3 ])
                            |> Expect.true "subset (fromList [ 1, 2, 3 ]) (fromList [ 4, 1, 2, 3 ]) should be True"
            , skip <|
                test "set is not a subset of set that does not contain its elements" <|
                    \() ->
                        CustomSet.subset (CustomSet.fromList [ 1, 2, 3 ]) (CustomSet.fromList [ 4, 1, 3 ])
                            |> Expect.false "subset (fromList [ 1, 2, 3 ]) (fromList [ 4, 1, 3 ]) should be False"
            ]
        , describe "Sets are disjoint if they share no elements"
            [ skip <|
                test "the empty set is disjoint with itself" <|
                    \() ->
                        CustomSet.disjoint CustomSet.empty CustomSet.empty
                            |> Expect.true "disjoint empty empty should be True"
            , skip <|
                test "empty set is disjoint with non-empty set" <|
                    \() ->
                        CustomSet.disjoint CustomSet.empty (CustomSet.fromList [ 1 ])
                            |> Expect.true "disjoint empty (fromList [ 1 ]) should be True"
            , skip <|
                test "non-empty set is disjoint with empty set" <|
                    \() ->
                        CustomSet.disjoint (CustomSet.fromList [ 1 ]) CustomSet.empty
                            |> Expect.true "disjoint (fromList [ 1 ]) empty should be True"
            , skip <|
                test "sets are not disjoint if they share an element" <|
                    \() ->
                        CustomSet.disjoint (CustomSet.fromList [ 1, 2 ]) (CustomSet.fromList [ 2, 3 ])
                            |> Expect.false "disjoint (fromList [ 1, 2 ]) (fromList [ 2, 3 ]) should be False"
            , skip <|
                test "sets are disjoint if they share no elements" <|
                    \() ->
                        CustomSet.disjoint (CustomSet.fromList [ 1, 2 ]) (CustomSet.fromList [ 3, 4 ])
                            |> Expect.true "disjoint (fromList [ 1, 2 ]) (fromList [ 3, 4 ]) should be True"
            ]
        ]
