# Introduction

Characters and Strings form the basis for text representation in Elm.
Strings can be thought of as lists of characters and most `List` functions have their equivalent in the `String` module.

## Characters

The `Char` type represents a single unicode character with single quotes e.g. `'a'`. 
The `Char` module provides predicate functions (`Char -> Bool`) to test qualities of a character: `isUpper`, `isLower`, `isAlpha`, and `isAlphaNum`.
The module also provides functions to convert a character `toUpper`, `toLower`, `toLocaleUpper`, `toLocaleLower`, as well as to/from their numerical unicode value (`Int`) with `toCode` and `fromCode`.

## Strings

The `String` type provides a built-in representation for efficient string manipulation and can represent any sequence of unicode characters.
Strings are represented with double quotes: `"this is a string"`.
Multi-line strings are represented with triple double quotes and can have unescaped quotes and newlines.

```elm 
haiku = 
"""
    Code's strings entwine
    , In binary, thoughts combine
    , Logic's elegant line.
"""
```

## String Manipulation

`reverse : String -> String` reverses the string.
```elm 
reverse "Hello world." 
    --> ".dlrow olleH"
```

`repeat : Int -> String -> String` repeats a string n times.
```elm 
repeat 2 "Hello world." 
    --> "Hello world.Hello world."
```

`replace : String -> String -> String -> String` replaces all occurrences of a given substring.
```elm
replace "Hello" "Goodbye cruel" "Hello world." 
    --> "Goodbye cruel world."
```

`append : String -> String -> String` appends two strings.
The `++` operator can also be used to do this.
```elm
append "butter" "fly" 
    --> "butterfly"
"butter" ++ "fly" 
    --> "butterfly"
```

`concat : List String -> String` concatenates a list of strings into a single string.
```elm
concat ["never", "the", "less"] 
    --> "nevertheless"
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

`words : String -> List String` breaks a string into strings, splitting on chunks of whitespace.
```elm
words "How are \t you? \n Good?" 
    --> ["How", "are", "you?", "Good?"]
```

`lines : String -> List String` breaks a string into lines, splitting on newlines.
```elm
lines "How are you?\nGood?" 
    --> ["How are you?", "Good?"]
```

`cons : Char -> String -> String` adds a character to the beginning of a string.
```elm
cons 'T' "he truth is out there" 
    --> "The truth is out there"
```

`uncons : String -> Maybe ( Char, String )` splits a non-empty string into its head and tail.
This lets you pattern match on strings exactly as you would with lists.
Empty strings return `Nothing`.
```elm
uncons "abc" 
    --> Just ('a', "bc")
uncons ""
    --> Nothing
```

## Getting Substrings

`slice : Int -> Int -> String -> String` takes a substring given a start and end index.
Negative indexes are taken starting from the end of the list.
```elm
slice 0 6 "snakes on a plane!" 
    --> "snakes"
slice 0 -7 "snakes on a plane!"
    --> "snakes on a"
```

`left : Int -> String -> String` and `right : Int -> String -> String` take n characters from the left or right side of the string respectively.

```elm
left 2 "Mulder" 
    --> "Mu"
right 2 "Scully" 
    --> "ly"
```

`dropLeft : Int -> String -> String` and `dropRight : Int -> String -> String` drop n characters from the left or right side of a string respectively.
```elm
dropRight 6 "Hello world." 
    --> "Hello"
dropLeft 6 "Hello world." 
    --> "world"
```

## Checking String Qualities

`length : String -> Int` returns the number of characters in a string.
```elm 
length "Hello world." 
    --> 12
```

`isEmpty : String -> Bool` determines if a string is empty. 
```elm 
isEmpty "Hello world." 
    --> False
```

`contains : String -> String -> Bool` checks if the second string contains the first one.
```elm
contains "the" "theory" 
    --> True
contains "THE" "theory" 
    --> False
```

`startsWith : String -> String -> Bool` and `endsWith : String -> String -> Bool` check if the second string starts/ends with a given substring.
```elm
startsWith "the" "theory" 
    --> True
endsWith "ory" "theory" 
    --> True
```

`indexes : String -> String -> List Int` gets a list of all the starting indexes of a substring in another string.
```elm
indexes "ss" "Mississippi"  
    --> [2, 5]
```

## Converting Strings
`toInt : String -> Maybe Int` tries to convert a string into `Just Int`, and returns `Nothing` for improperly formatted strings.
```elm
toInt "-42" 
    --> Just -42
toInt "3.1" 
    --> Nothing
toInt "two" 
    --> Nothing
```

`fromInt : Int -> String` converts an integer to a string.
```elm
fromInt -42 
    --> "-42"
```

`toFloat : String -> Maybe Float` tries to convert a string into a float, failing on improperly formatted strings.
```elm
toFloat "-42" 
    --> Just -42.0
toFloat "3.1" 
    --> Just 3.1
toFloat "two" 
    --> Nothing
```

`fromFloat : Float -> String` converts a float to a string.
```elm
fromFloat 3.9 
    --> "3.9"
```

`toList : String -> List Char` and `fromList : List Char -> String` convert a string to and from a list of characters respectively.
```elm 
toList "abc" 
    --> ['a', 'b', 'c']
fromList ['a', 'b', 'c'] 
    --> "abc"
```

`fromChar : Char -> String` converts a character to a string.
```elm
fromChar 'a' 
    --> "a"
```

## Formatting Strings

`toUpper : String -> String` and `toLower : String -> String` convert strings to all upper or all lower case respectively.
Useful for case-insensitive comparisons.
```elm
toUpper "skinner" 
    --> "SKINNER"
toLower "X-FILES" 
    --> "x-files"
```

`pad : Int -> Char -> String -> String` pads a string on both sides with the provided `Char` until it has the given length.
```elm
pad 5 ' ' "11"  
    --> "  11 "
```
Similarly, `padLeft` and `padRight` pad a string on either side until it has a given length.

`trim : String -> String` removes whitespace on both sides of a string.
```elm
trim "  hats  \n" 
    --> "hats"
```
`trimLeft` and `trimRight` remove whitespace on either side of a string.

## Higher-Order Functions

`map : (Char -> Char) -> String -> String` transforms every character in a string with the given function.
Note the function provided must be a mapping from and to `Char`.
```elm
map (\c -> if c == '/' then '.' else c) "a/b/c" 
    --> "a.b.c"
```

`filter : (Char -> Bool) -> String -> String` keeps only the characters that pass the test.
```elm
filter isDigit "R2-D2" 
    --> "22"
```

`foldl : (Char -> b -> b) -> b -> String -> b` reduces a string starting from the left.
The function is applied with the first character as its first parameter and an initial value provided as its second parameter.
The result of the function must be of the same type as the as the initial value provided and is applied to each character in sequence.
```elm
foldl (\c acc -> Char.toCode c + acc) 0 "the sum of my unicode is " 
    --> 2260
```
`foldr` does the same but starting from the right side of the string.

`any : (Char -> Bool) -> String -> Bool` determines whether any character returns `True` to the predicate provided.
```elm
any isDigit "R2-D2" 
    --> True
any isDigit "heart" 
    --> False
```
`all : (Char -> Bool) -> String -> Bool` determines if all characters in a string return `True` to the predicate provided.
```elm
all isDigit "R2-D2" 
    --> False
all isAlpha "heart" 
    --> True
```