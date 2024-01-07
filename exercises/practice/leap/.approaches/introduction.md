# Introduction

There are various idiomatic approaches to solve Leap.
All approaches listed below check for divisibility by 4, 100, and 400.
However, they differ in the ways in which they combine these checks.

## Approach: a logical expression

```elm
isLeapYear : Int -> Bool
isLeapYear year = 
  let
    divisbleBy number = 
      modBy number year == 0 
  in
    divisibleBy 4 && (not (divisibleBy 100) || divisibleBy 400)
```

A logicial expression is the most concise approach.
[Read more about this approach][logical-expression].

## Approach: an if expression

```elm
isLeapYear : Int -> Bool
isLeapYear year =
  let
    divisbleBy number = 
      modBy number year == 0 
  in
    if divisbleBy(400) then
      return True
    
    else if divisbleBy(100) then
      return False
    
    else if divisbleBy(4) then
      return True
    
    else
      return False
```

An if statement is not as concise, but is [easier to describe][describable-code].
[Read more about this approach][if-expression].

## Approach: a case expression

```elm
isLeapYear : Int -> Bool
isLeapYear year =
  let
    isDivisibleByFour = (modBy 4 year) == 0
    isDivisibleBy100 = (modBy 100 year) == 0
    isDivisibleBy400 = (modBy 400 year) == 0
  in
    case (isDivisibleByFour, isDivisibleBy100, isDivisibleBy400) of
      (True, _, True) -> True
      (True, False, _) -> True
      _ -> False
```

This takes a [truth-table][truth-table] like approach, which can be easier to read for complicated logic.
[Read more about this approach][case-expression].

## Other approaches

There are also more esoteric approaches, [such as this one using recursion, an array and a case statement][esoteric-approach], that are not idiomatic, but that can be interesting to look at, and probably come about by trying to solve the problem using some artificial constraints, as you would often do in a code kata.

## General guidance

The key to determining whether a given year is a leap year is to know whether the year is evenly divisible by `4`, `100`, and `400`.
For determining that, you can use the [`modBy` function][modby-function], which yields the remainder after division.

You don't need to use a ['let' statement][let-statement] to define an `isDivisibleBy` function, although all the examples here do to aid readability.

## Which approach to use?

Code exists primarily for humans to read and reason about.
Therefore, in general, go with the approach that _makes the most sense_.

All approaches listed here are valid choices unless marked otherwise.
Be sure to check out all of their individual pages though: they each have interesting things to say!

[logical-expression]:
  https://exercism.org/tracks/elm/exercises/leap/approaches/conditional-expression
  "Approach: a conditional expression"
[if-expression]:
  https://exercism.org/tracks/elm/exercises/leap/approaches/if-statement
  "Approach: an if statement"
[case-expression]:
  https://exercism.org/tracks/elm/exercises/leap/approaches/case-statement
  "Approach: a case statement"

[describable-code]:
  https://www.freecodecamp.org/news/writing-describable-code/
  "Writing easily describable code"
[truth-table]:
  https://brilliant.org/wiki/truth-tables/
  "Writing easily describable code"
[esoteric-approach]
  https://exercism.org/tracks/elm/exercises/leap/solutions/edgerunner
  "An esoteric solution to leap, using recursion, an array and a case statement"
[modby-function]
  https://package.elm-lang.org/packages/elm/core/latest/Basics#modBy
  "modBy function in Elm"
