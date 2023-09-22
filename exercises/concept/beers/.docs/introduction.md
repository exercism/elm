# Introduction

Characters and Strings form the basis for text representation in Elm.
Strings can be thought of as lists of characters and most `List` functions have their equivalent in the `String` module.

## Characters

The `Char` type represents a single unicode character with single quotes e.g. 'a'. 
The `Char` module provides predicate functions (`Char -> Bool`) to test qualities of a character: `isUpper`, `isLower`, `isAlpha`, and `isAlphaNum`
The module also provides functions to convert a character `toUpper`, `toLower`, `toLocaleUpper`, `toLocaleLower`, as well as to/from their numerical unicode value (`Int`) with `toCode` and `fromCode`.

## Strings

The `String` type provides a built-in representation for efficient string manipulation and can represent any sequence of unicode characters.
Multi-line strings are represented with triple double quotes and can have unescaped quotes and newlines.

## String Functions

The String module contains the following functions: 

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