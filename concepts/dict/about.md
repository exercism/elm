# About

A [`Dict`][dict] in Elm is an immutable dictionary of zero or more key-value pairs.

Dicts are manipulated by functions and operators defined in the [`Dict` module][dict-module].

Type annotations for dicts are written as follows

```elm
Dict String (List Int) --> a dict with String keys and List Int values
Dict Int String --> a dict with Int keys and String values
```

Dicts can be created as follows:

```elm
empty : Dict Int String
empty = Dict.empty

singleValue = Dict.singleton 5 "Value for key 5" --> Dict Int String

twoValues = Dict.fromList [ ( "Alice", 0 ), ( "Bob", 1 ) ] --> Dict String Int
```

Items can be retrieved using `get`.
As a key may or may not be present in the dict, the result will be wrapped in a `Maybe`.

```elm
alice = Dict.fromList [ ( 0, "Alice" ) ]
keyExists = Dict.get 0 alice --> Just "Alice"
keyNotPresent = Dict.get 1 alice --> Nothing
```

Items can be added using `insert`.
Items for keys that are already in the dict get replaced.

```elm
alice = Dict.fromList [ ( "Alice", 0 ) ]
aliceAndBob = Dict.insert "Bob" 1 alice  --> Dict.fromList [ ( "Alice", 0 ), ( "Bob", 1 ) ]
aliceAndAlice = Dict.insert "Alice" 1 alice  --> Dict.fromList [ ( "Alice", 1 ) ]
```

Items can be updated using `update`.
If the key doesn't exist the update function will be called with `Nothing`.

```elm
alice = Dict.fromList [ ( 0, "Alice" ) ]
aliceUpperCase = Dict.update 0 (Maybe.map String.toUpper) alice --> Dict.fromList [ ( 0, "ALICE" ) ]
aliceNoCase = Dict.update 0 (\_ -> Nothing) alice --> Dict.empty
bobUpperCase = Dict.update 1 (\_ -> Just "BOB") alice --> Dict.fromList [ ( 0, "Alice" ), ( 1, "BOB" ) ]
bobNoCase = Dict.update 1 (\_ -> Nothing) alice --> Dict.fromList [ ( 0, "Alice" ) ]
```

Items can be removed using `remove`.
If the key doesn't exist, no change is made.

```elm
alice = Dict.fromList [ ( 0, "Alice" ) ]
stillAlice = Dict.remove 1 --> ( 0, "Alice" )
empty = Dict.remove 0 alice --> Dict.empty
```

A list of key value pairs can be converted into a list with `fromList`.

```elm
alice = Dict.fromList [ ( 0, "Bob" ), ( 0, "Alice" ) ]
--> True Dict.fromList [ ( 0, "Alice" ) ]
```

Items can be converted to a list using `toList`.
The list is ordered by the keys.

```elm
aliceAndBob = Dict.fromList [ ( 1, "Alice" ), ( 0, "Bob" ) ]
bobAndAlice = Dict.toList aliceAndBob
--> [ ( 0, "Bob" ), ( 1, "Alice" ) ]
```

Multiple items can be removed using `filter`.

```elm
aliceAndBob = Dict.fromList [ ( "Alice", 1 ), ( "Bob", 0 ) ]
bob = Dict.filter (\name count) -> name == "Bob") aliceAndBob --> Dict.fromList [ ( "Bob", 0 ) ]
```

Items can be transformed using `map`.

```elm
alice = Dict.fromList [ ( "Alice", 0 ) ]
empty = Dict.map (\player count -> count + 1) --> Dict.fromList [ ( "Alice", 1 ) ]
```

Dicts can be combined / transformed using `merge`.

```elm
aliceAndBob = Dict.fromList [ ( "Alice", 1 ), ( "Bob", 1 ) ]
bobAndCedd = Dict.fromList [ ( "Bob", 1 ), ( "Cedd", 1 ) ]
firstDictCountsDouble = Dict.merge
        -- when only in aliceAndBob
        (\name count mergedCounts -> Dict.insert name (2 * count) mergedCounts)
        -- when in aliceAndBob and bobAndCedd
        (\name aliceAndBobCount bobAndCeddCount mergedCounts -> Dict.insert name (2 * aliceAndBobCount + bobAndCeddCount) mergedCounts)
        -- when only in bobAndCedd
        (\name count mergedCounts -> Dict.insert name count mergedCounts)
        -- the two dicts to merge
        aliceAndBob
        bobAndCedd
        -- the initial state of the merge
        Dict.empty
--> Dict.fromList [ ( "Alice", 2 ), ( "Bob", 3 ), ( "Cedd", 1 ) ]
```

Any function/operator that appears to modify a dict (such as adding an element), will actually return a new dict.
Performance is usually not an issue, as the implementation prevents unnecessary allocations/copies.

In Elm, it is generally better to use higher level abstractions, such as `Dict.map`, `Dict.filter` and `Dict.merge`, instead of lower level abstractions such as `Dict.get` and `Dict.remove`, although it does of course depend on the context.

[dict]: https://riptutorial.com/elm/example/7088/dictionaries
[dict-module]: https://package.elm-lang.org/packages/elm/core/latest/Dict
