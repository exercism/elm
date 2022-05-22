# About

A [`Dict`][dict] in Elm is an immutable dictionary of zero or more key-value pairs.

Type annotations for dicts are be written as follows

```elm
Dict String (List Int) --> a dict with String keys and List Int values
Dict Int String --> a dict with Int keys and String values
```

Dicts can be created as follows:

```elm
empty : Dict Int String
empty = Dict.empty

singleValue = Dict.singleton 5 "Value for key 5" --> Dict Int String

twoValues = Dict.fromList [ ( 0, "Alice" ), ( 1, "Bob" ) ] --> Dict Int String
```

Items can be retrieved using `get`.
As a key may or may not be present in the dict, the result will be wrapped in a `Maybe`.

```elm
alice = Dict.fromList [ ( 0, "Alice" ) ]
keyExists = Dict.get 0 --> Just "Alice"
keyNotPresent = Dict.get 1 --> Nothing
```

Items can be added using `insert`. 
Items for keys that are already in the dict get replaced.

```elm
alice = Dict.fromList [ ( 0, "Alice" ) ]
aliceAndBob = Dict.insert 1 "Bob" alice  --> ( 0, "Alice" ), ( 1, "Bob" )
```

Items can be updated using `update`.

```elm
alice = Dict.fromList [ ( 0, "Alice" ) ]
aliceUpperCase = Dict.update 0 (Maybe.map toUpper)  --> Dict.fromList [ ( 0, "ALICE" ) ]
aliceNoCase = Dict.update 0 (\_ -> Nothing)  --> Dict.empty
bobUpperCase = Dict.update 1 (\_ -> Just "BOB") --> Dict.fromList [ ( 0, "Alice" ), ( 1, "BOB" ) ]
bobNoCase = Dict.update 1 (\_ -> Nothing) --> Dict.fromList [ ( 0, "Alice" ) ]
```

Items can be removed using `remove`.

```elm
alice = Dict.fromList [ ( 0, "Alice" ) ]
empty = Dict.remove 0 --> Dict.empty
```

Dicts are manipulated by functions and operators defined in the [`Dict` module][dict-module].

[dict]: https://riptutorial.com/elm/example/7088/dictionaries
[dict-module]: https://package.elm-lang.org/packages/elm/core/latest/Dict
