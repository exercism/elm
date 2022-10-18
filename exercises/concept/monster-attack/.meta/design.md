# Design

## Learning objectives

- Know that calling a function without all its arguments returns a new function.
- Understand the arrows notation `->` in type annotations.
- Know how convenient is partial applications in pipes `|>`.
- Understand how partial application and pipes encourage placement of the main data structure as last argument of functions.

## Out of scope

- Composition of partial functions is out of scope, left for another concept.

## Concepts

- partial-application-composition

## Prerequisites

- basics-2

## Analyzer

This exercise could benefit from the following rules added to the the [analyzer][analyzer]:

- Verify that the pipeline operator is used in `attack`
- Verify that attackWithClaw and attahWithSword are only used once each in `attack`

[analyzer]: https://github.com/exercism/elm-analyzer
