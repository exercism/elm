# About

A `Set a` is a sequence of unique values of type `a`.
The values have to be of the `comparable` type (`Int`, `Float`, `Time`, `Char`, `String`, and tuples or lists of comparable types).

You can transform lists and sets into each other with `Set.toList` and `Set.fromList`.

```elm
Set.fromList [2, 3, 3, 3, 1, 1, 2]
    --> Set.fromList [1, 2, 3]

Set.toList (Set.fromList [2, 3, 3, 3, 1, 1, 2])
    --> [1, 2, 3]
```

You can create and populate sets with `Set.empty`, `Set.singleton`, `Set.insert` and `Set.remove`.

```elm
Set.empty
    --> Set.fromList []

Set.singleton "hi"
    --> Set.fromList ["hi"]

eightEight = Set.singleton 88

Set.insert 88 eightEight
    --> Set.fromList [88]

Set.insert 89 eightEight
    --> Set.fromList [88, 89]

Set.remove 88 eightEight
    --> Set.fromList []

Set.remove 89 eightEight
    --> Set.fromList [88]
```

You can check if an element is a member of a set with `Set.member`.

```elm
Set.member 88 eightEight
    --> True
```

Set can be combined with `Set.union`, `Set.intersect` and `Set.diff`.

```elm
a = Set.fromList [1, 10, 100]
b = Set.fromList [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

Set.union a b
    --> Set.fromList [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 100]

Set.intersect a b
    --> Set.fromList [1, 10]

Set.diff a b
    --> Set.fromList [100]

Set.diff b a
    --> Set.fromList [2, 3, 4, 5, 6, 7, 8, 9]
```

You can filter and partition sets.

```elm
even n = modBy 2 n == 0

Set.filter even b
    --> Set.fromList [2, 4, 6, 8, 10]

Set.partition even b
    --> (Set.fromList [2, 4, 6, 8, 10], Set.fromList [1, 3, 5, 7, 9])
```
