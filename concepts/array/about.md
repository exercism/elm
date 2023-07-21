# About

An [`Array`][array] in Elm is a fast immutable collection of zero or more values of the same type.
As arrays are immutable, once an array has been constructed, its value can never change.
There is no literal syntax for arrays (like there is for list), so instead the Array.fromList syntax is used.
For example, an `Array` with "a", "b" and "c" in it is usually shown as `Array.fromList ["a", "b", "c"]``.
You will see this on console output, in the debugger, and other places like that.

Unlike `List` which is a [default-import][default import], the `Array` module must be explicity imported, using `import Array` or similar.

Type annotations for lists can be defined as follows

```elm
Array String --> an array of String
Array Int --> an array of Int
```

Arrays can be defined as follows:

```elm
import Array exposing Array

empty : Array Char
empty = Array.empty

singleValue = Array.fromList [ 5 ] --> Array Int

repeatSingleValue = Array.repeat 2 5 --> Array.fromList [ 5, 5 ]

initialiseFromIndex = Array.initialise 3 (\index -> index * 2) --> Array.fromList [ 0, 2, 4 ]

initialisefromList = Array.fromList [ "a", "b", "c" ] --> Array.fromList [ "a", "b", "c" ]
```

Elements are added to an Array using `Array.push`:

```elm
twoToFour = Array.fromList [ 2, 3, 4 ]
oneToFour = Array.push 1 twoToFour --> Array.fromList [ 1, 2, 3, 4 ]
```

Arrays are appended using `Array.append`:

```elm
sixSeven = Array.fromList [ 6, 7 ]
eightNine = Array.fromList [ 8, 9 ]           
Array.append sixSeven eightNine --> Array.fromList [ 6, 7, 8, 9 ]
```

An element in an Array is retrieved using `Array.get`:

```elm
sixSeven = Array.fromList [ 6, 7 ]    
Array.get 0 sixSeven --> 6
```

An element in an Array is set using `Array.set`:

```elm
sixSeven = Array.fromList [ 6, 7 ]    
Array.set 1 8 sixSeven --> Array.fromList [ 6, 8 ]
```

Arrays are manipulated by functions defined in the [`Array` module][array-module].

```elm
oneTwo = Array.fromList [ 1, 2 ]
Array.length oneTwo --> 2
```

Any function/operator that appears to modify an `Array`` (such as adding an element), will actually return a new `Array`.
Performance is usually not an issue though, as the implementation of `Array` prevents unnecessary allocations/copies.

[array]: https://elmprogramming.com/array.html
[array-module]: https://package.elm-lang.org/packages/elm/core/latest/Array
[default-imports]: https://github.com/elm/core#default-imports
