# Hints

## General

- Check out the [`elm/parser` documentation][elm-parser]
- The introduction introduces all the necessary concepts to solve the exercise

## 1. Parse pizza price

- There is a [dedicated parser][int] for integers
- More than one parsers can handle €, [one of them][symbol] is most appropriate
- There is a [function][(|.)] to parse two things but keep only one

## 2. Parse vegetarian indicator

- There is a [parser very appropriate][oneOf] for trying different possibilities
- There is more than one way to parse a specific string, in this case [this one][keyword] or this one [that one][symbol] are appropriate
- There is more than one way to return `True` if a parser succeeds, you can try [this one][succeed] or [that one][map]

## 3. Parse pizza and ingredient names

- There are [functions][chompWhile] dedicated to parsing arbitrary characters
- There is a [function][isAlpha] that can validate upper case and lower case ASCII characters 

## 4. Parse a list of ingredients

- There is a [function][sequence] dedicated to parsing lists of items
- Use all the appropriate functions you defined so far

## 5. Parse full pizza

- It is [quite simple][(|=)] to keep more than one thing in a pipeline
- Use `Pizza` as a type constructor with a [handy function][succeed]
- More than one parsers can handle ":" and "-", [one of them][symbol] is most appropriate
- There is a [handy function][spaces] to get rid of extra spaces
- Use all the appropriate functions you defined so far

## 6. Parse full menu

- There is a [function][sequence] dedicated to parsing lists of items
- Remember that `Parser.spaces` consumes newline characters too, this might interfere with your separator
- There is a [function][end] dedicated to checking you reached the end of a string
- There is a [function][(|.)] to parse two things but keep only one
- Use all the appropriate functions you defined so far

## 7. Parse multi-word ingredient names

- There are [functions][chompWhile] dedicated to parsing arbitrary characters
- There is a [function][isAlpha] that can validate upper case and lower case ASCII characters 
- There is a [function][andThen] that can be used to inspect the contents of a parser
- There is a [function][problem] that indicates that you reached a dead end
- There is a [`String` function][trim] that can get rid of white spaces at the edges of a string



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
