# Introduction

## Strings

Characters and Strings form the basis for text representation in Elm.
Strings can be thought of as lists of characters and most `List` functions have their equivalent in the `String` module.

### Characters

The `Char` type represents a single unicode character with single quotes e.g. `'a'`. 
The `Char` module provides predicate functions (`Char -> Bool`) to test qualities of a character: `isUpper`, `isLower`, `isAlpha`, and `isAlphaNum`
The module also provides functions to convert a character `toUpper`, `toLower`, `toLocaleUpper`, `toLocaleLower`, as well as to/from their numerical unicode value (`Int`) with `toCode` and `fromCode`.

### Strings

The `String` type provides a built-in representation for efficient string manipulation and can represent any sequence of unicode characters e.g. "this is an Elm string."
Multi-line strings are represented with triple double quotes and can have unescaped quotes and newlines.
```elm
"""
    This is a multiline string.
All line-breaks and whitespace,
are preserved. 
"""
```

### String Functions

The `String` module contains all the functions summarized on the table below.
Some of the most commonly used functions include:

`cons : Char -> String -> String` adds a character to the beginning of a string.
```elm
cons 'T' "he truth is out there" 
    --> "The truth is out there"
```

`(++): String -> String -> String` appends two strings.
```elm
"butter" ++ "fly" 
    --> "butterfly"
```

`split : String -> String -> List String` splits a string into a list of strings at the given separator.
```elm
split ";" "cat;dog;cow" 
    --> ["cat", "dog", "cow"]
```

`join : String -> List String -> String` concatenates a list of strings together with a given separator.
```elm
join "a" ["H", "w", "ii", "n"] 
    --> "Hawaiian"
```
`replace : String -> String -> String -> String` replaces all occurrences of a given substring.
```elm
replace "Hello" "Goodbye cruel" "Hello world." 
    --> "Goodbye cruel world."
```

`length : String -> Int` returns the number of characters in a string.
```elm 
length "Hello world." 
    --> 12
```

`toInt : String -> Maybe Int` tries to convert a string into `Just Int`, and returns `Nothing` for improperly formatted strings.
```elm
toInt "-42" 
    --> Just -42
```    

`contains : String -> String -> Bool` checks if the second string contains the first one.
```elm
contains "the" "theory" 
    --> True
```

`map : (Char -> Char) -> String -> String` applies a given function to every `Char` in the string.
Note the function provided must be a mapping from and to `Char`.
```elm
map (\c -> if c == '/' then '.' else c) "a/b/c" 
    --> "a.b.c"
```

### All String Functions:
| Manipulate | Substrings | Check       | Convert      | Higher Order |
|------------|------------|-------------|--------------|--------------|
| `reverse`  | `slice`    | `length`    | `toInt`      | `map`        | 
| `repeat`   | `left`     | `isEmpty`   | `fromInt`    | `filter`     | 
| `replace`  | `right`    | `contains`  | `toFloat`    | `foldl`      |
| `append`   | `dropLeft` | `startsWith`| `fromFloat`  | `foldr`      |   
| `concat`   | `dropRight`| `indexes`   | `toList`     | `any`        |
| `split`    |            |             | `fromList`   | `all`        |
| `join`     |            |             | `fromChar`   |              |
| `words`    |            |             |              |              |
| `lines`    |            |             |              |              |
| `cons`     |            |             |              |              |
| `uncons`   |            |             |              |              |
