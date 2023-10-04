# Hints

## General
- [This tutorial][string-tutorial] is useful.
- [Reference documentation][string-docs] for `String`.

## 1. Replace any spaces encountered with underscores
- `String` provides a [replace][replace] function.

## 2. Replace control characters with the upper case string "CTRL"
- You can separate strings into a list of strings with `String.split`
- You can [concatenate][concat] or [append][append] multiple strings.

## 3. Convert kebab-case to camelCase
- `char` literals are enclosed in single quotes.
- [Char.toUpper][toUpper] converts a character to upper case.
- Consider the use of higher-order functions to work your way through the entire string.

## 4. Omit digits
- `Char` provides functions to detect [digits][isDigit] and [alphabetic][isAlpha] characters.

## 5. Omit Greek lower case letters
- `Char` can transform characters [to/from their unicode decimal values][toCode].
- Lower case [Greek letters][greek] form a contiguous Unicode block.

[string-tutorial]:https://elmprogramming.com/string.html
[string-docs]: https://package.elm-lang.org/packages/elm/core/latest/String
[replace]: https://package.elm-lang.org/packages/elm/core/latest/String#replace
[concat]: https://package.elm-lang.org/packages/elm/core/latest/String#concat
[append]: https://package.elm-lang.org/packages/elm/core/latest/String#append
[whitespace]: https://en.wikipedia.org/wiki/Whitespace_character#Unicode
[controlChars]: https://en.wikipedia.org/wiki/Unicode_control_characters
[toUpper]: https://package.elm-lang.org/packages/elm/core/latest/Char#toUpper
[isDigit]: https://package.elm-lang.org/packages/elm/core/latest/Char#isDigit
[isAlpha]: https://package.elm-lang.org/packages/elm/core/latest/Char#isAlpha
[toCode]: https://package.elm-lang.org/packages/elm/core/latest/Char#toCode
[greek]: https://www.compart.com/en/unicode/scripts/Grek
