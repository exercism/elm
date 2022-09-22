# Design

## Goal

The goal of this exercise is to teach students how to use `elm/parser`, and to state that this is the idiomatic way of parsing in Elm.

## ## Learning objectives

- Understand parser pipelines
- Parsers: Parser, run
- Building blocks: int, symbol
- Pipelines: succeed, (|=), (|.), andThen, problem
- Branches: oneOf, map 
- Loops: sequence
- Whitespace: spaces
- Chompers: getChompedString, chompIf, chompWhile

## Out of scope

- Understand backtracking???
- Understand tracking context???

- Building blocks: number, variable, keyword, end
- Pipelines: lazy, 
- Branches: backtrackable, commit, token, 
- Loops: loop
- Whitespace: lineComment, multiComment
- Chompers: chompUntil, chompUntilEndOr, mapChompedString
- Errors
- Indentation
- Positions
- Parser.advanced

## Concepts

The concepts this exercise unlock are:

- "Parse don't validate"

## Prerequisites

- `basics-1`
- `basics-2`
- `booleans`
- `tuples`
- `lists`
- `records`
- `custom-types`
- `maybe`
- `result`

## Analyzer

Make sure that:

- X is called with Y
