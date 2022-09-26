# Hints

## General

- Check out the [`elm/parser` documentation][elm-parser]
- The introduction introduces all the necessary concepts to solve the exercise

## 1. Parse pizza price

- The [`int` parser][int] is dedicated to parsing integers
- More than one parser can handle €, but [`symbol`][symbol] is the most appropriate
- The [`(|.)` operator][(|.)] can parse two things but keep only one

## 2. Parse vegetarian indicator

- The [`oneOf` parser][oneOf] can try different possibilities
- There is more than one way to parse a specific string, in this case [`keyword`][keyword] or [`symbol`][symbol] are appropriate
- There is more than one way to return `True` if a parser succeeds, you can try with [`succeed`][succeed] or with a [`map`][map]

## 3. Parse pizza and ingredient names

- The [`chompWhile` parser][chompWhile] is dedicated to parsing arbitrary characters
- The [`isAlpha` function][isAlpha] can validate upper case and lower case ASCII characters 

## 4. Parse a list of ingredients

- The [`sequence` parser][sequence] is dedicated to parsing lists of items
- Use all the appropriate functions you defined so far

## 5. Parse full pizza

- It is quite simple with the [`(|=)` operator][(|=)] to keep more than one thing in a pipeline
- Use `Pizza` as a type constructor with [`succeed`][succeed]
- More than one parser can handle ":" and "-", but [`symbol`][symbol] is the most appropriate
- The [`spaces` parser][spaces] is handy to get rid of extra spaces
- Use all the appropriate functions you defined so far

## 6. Parse full menu

- The [`sequence` parser][sequence] is dedicated to parsing lists of items
- Remember that `spaces` consumes newline characters too, this might interfere with your separator
- The [`end` parser][end] is dedicated to checking you reached the end of a string
- The [`(|.)` operator][(|.)] can parse two things but keep only one
- Use all the appropriate functions you defined so far

## 7. Parse multi-word ingredient names

- The [`chompWhile` parser][chompWhile] is dedicated to parsing arbitrary characters
- The [`isAlpha` function][isAlpha] can validate upper case and lower case ASCII characters 
- The [`andThen` function][andThen] can be used to inspect the contents of a parser
- The [`problem` function][problem] returns a parser that reached a dead end
- The [`String.trim` function][trim] can get rid of white spaces at the edges of a string



[elm-parser]: https://package.elm-lang.org/packages/elm/parser/latest/
[int]: https://package.elm-lang.org/packages/elm/parser/latest/Parser#int
[symbol]: https://package.elm-lang.org/packages/elm/parser/latest/Parser#symbol
[oneOf]: https://package.elm-lang.org/packages/elm/parser/latest/Parser#oneOf
[map]: https://package.elm-lang.org/packages/elm/parser/latest/Parser#map
[succeed]: https://package.elm-lang.org/packages/elm/parser/latest/Parser#succeed
[keyword]: https://package.elm-lang.org/packages/elm/parser/latest/Parser#keyword
[chompWhile]: https://package.elm-lang.org/packages/elm/parser/latest/Parser#chompWhile
[sequence]: https://package.elm-lang.org/packages/elm/parser/latest/Parser#sequence
[(|=)]: https://package.elm-lang.org/packages/elm/parser/latest/Parser#(|=)
[(|.)]: https://package.elm-lang.org/packages/elm/parser/latest/Parser#(|.)
[spaces]: https://package.elm-lang.org/packages/elm/parser/latest/Parser#spaces
[end]: https://package.elm-lang.org/packages/elm/parser/latest/Parser#end
[andThen]: https://package.elm-lang.org/packages/elm/parser/latest/Parser#andThen
[problem]: https://package.elm-lang.org/packages/elm/parser/latest/Parser#problem
[trim]: https://package.elm-lang.org/packages/elm/core/1.0.5/String#trim
[isAlpha]: https://package.elm-lang.org/packages/elm/core/1.0.5/Char#isAlpha
