# About

A [`Dict`][dict] in Elm is an immutable dictionary of zero or more key-value pairs. The keys can be any `comparable` type (`String`, `Int`, `Float`, `Time`), and the values can be any type.
As dicts are immutable, once a dict has been constructed, its value can never change, although you can create a new one based on an old one, as with most things in Elm.
Insert, remove, and query operations all take O(log n) time.

Type annotations for dicts can be defined as follows

```elm
Dict String (List Int) --> a dict with String keys and List Int values
Dict Int String --> a dict with Int keys and String values
```

Dicts can be defined as follows:

```elm
empty : Dict Int String
empty = Dict.empty

singleValue = Dict.singleton 5 "Value for key 5" --> Dict Int String

twoValues = Dict.fromList [ (0, "Alice" ), (1, "Bob" ) ] --> Dict Int String
```

Items can be retrieved using `get`.

```elm
alice = Dict.fromList [ (0, "Alice" ) ]
keyExists = Dict.get 0 --> Just "Alice"
keyNotPresent = Dict.get 1 --> Nothing
```

Items can be added using `insert`. If the key already exists it will be replaced.

```elm
alice = Dict.fromList [ ( 0, "Alice" ) ]
aliceAndBob = Dict.insert 1 "Bob" alice  --> ( 0, "Alice" ), ( 1, "Bob" )
bob = Dict.insert 0 "Bob" alice  --> ( 0, "Bob" )
```

Items can be updated using `update`. If the key doesn't exist the update function will be called with `Nothing`.

```elm
alice = Dict.fromList [ ( 0, "Alice" ) ]
aliceUpperCase = Dict.update 0 (\maybeValue -> Maybe.map toUpper maybeValue)  --> ( 0, "ALICE" )
```

You can also leverage partial application to simplify the update function

```elm
alice = Dict.fromList [ ( 0, "Alice" ) ]
aliceUpperCase = Dict.update 0 (Maybe.map toUpper)  --> ( 0, "ALICE" )
```

Items can be removed using `remove`. If the key doesn't exist, no change is made

```elm
alice = Dict.fromList [ ( 0, "Alice" ) ]
stillAlice = Dict.remove 1 --> ( 0, "Alice" )
empty = Dict.remove 0 --> Dict.empty
```

Items can be converted to a list using `toList`. The list is ordered by the keys.

```elm
aliceAndBob = Dict.fromList [ ( 1, "Alice" ), ( 0, "Bob" ) ]
bobAndAlice = Dict.toList aliceAndBob
--> ( 0, "Bob" ), ( 1, "Alice" )
```

Dicts are manipulated by functions and operators defined in the [`Dict` module][dict-module].

```elm
alice = Dict.fromList [ ( 0, "Alice" ) ]
Dict.member 0 alice --> True
```

Any function/operator that appears to modify a dict (such as adding an element), will actually return a new dict.
Performance is usually not an issue though, as the implementation prevents unnecessary allocations/copies.

[dict]: https://riptutorial.com/elm/example/7088/dictionaries
[dict-module]: https://package.elm-lang.org/packages/elm/core/latest/Dict
