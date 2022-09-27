# Design

## Goal

The goal of this exercise is to teach students how to use `elm/parser`, and to state that this is the idiomatic way of parsing in Elm.

## Learning objectives

- Understand parser pipelines
- Parsers: Parser, run
- Building blocks: int, keyword, symbol, end
- Pipelines: succeed, (|=), (|.), andThen, problem
- Branches: oneOf, map 
- Loops: sequence
- Whitespace: spaces
- Chompers: getChompedString, chompWhile

## Out of scope

- Understand backtracking
- Understand tracking context
- Parser.advanced
- [Parsers with error recovery](https://discourse.elm-lang.org/t/parsers-with-error-recovery/6262)
- Building blocks: number, variable
- Pipelines: lazy
- Branches: backtrackable, commit, token, 
- Loops: loop
- Whitespace: lineComment, multiComment
- Chompers: chompIf, chompUntil, chompUntilEndOr, mapChompedString
- Errors, Indentation, Positions

## Concepts

- `parsing`: Learn the basics of parsing by processing the menu of Paola's Prestigious Pizza

## Prerequisites

- `basics-1`
- `basics-2`
- `booleans`
- `lists`
- `records`
- `result`

## Analyzer

- [essential] `priceParser` should use `int` (instead of `number`?)
- [essential] `vegetarianParser` should use `symbol` or `keyword` (both are ok)
- [essential] `vegetarianParser` should use `Parser.oneOf`
- [essential] `wordParser` should use `chompWhile`, `getChompedString`, and `map`
- [essential] `ingredientsParser` should use `oneIngredientParser`
- [essential] `pizzaParser` should use `wordParser`, `vegetarianParser`, `ingredientsParser` and `priceParser`
- [essential] `menuParser` should use `pizzaParser`
- [essential] `oneIngredientParser` should use `chompWhile`, `getChompedString` and `andThen`
- [actionable] `priceParser` should use `symbol` (more appropriate than `keyword` for €)
- [informative] `sequence` should be used anywhere for the sake of learning (instead of `loop`?)
