# Design

## Goal

The goal of this exercise is to understand pattern matching and destructuring in elm.

## Learning objectives

- Know how to pattern match on custom types.
- Know how to use wild cards `_` in pattern matching.
- Know how to use literals in pattern matching.
- Know how to pattern match recursively.
- Know how to use `as` in pattern matching.
- Know how to destructure in case expressions.
- Know how to destructure in function arguments.
- Know how to destructure in assignments.
- Know the naming limitations of destructuring records.

## Out of scope

- Nothing about pattern matching is out of scope.

## Concepts

The concepts this exercise unlock are:

- `pattern-matching`

## Prerequisites

- `custom-types`
- `lists`
- `maybe`
- `records`
- `tuples`

## Analyzer

Make sure that:
- `( User, String )` is destructured in `emptyComment`'s argument
- `User` is ignored with `_` in `emptyComment`'s argument


- `Ticket _` is destructured in `numberOfCreatorComments`'s argument
- `Ticket { createdBy, comments }` is destructured in `numberOfCreatorComments`'s argument
- `createdBy` is destructured in a `let` binding
- `( User, String )` is destructured in `List.filter` anonymous function


- `Ticket _` is destructured in `assignedToDevTeam`'s argument
- `Ticket { createdBy, comments }` is destructured in `assignedToDevTeam`'s argument
- `Just (User "Alice")` and friends are pattern matched in a `case`


- `Ticket _` is destructured in `assignTicketTo`'s argument
- `Ticket { createdBy, comments }` is destructured in `assignTicketTo`'s argument
- keyword `as` is used in `assignTicketTo`'s argument
- record update syntax is used
- wildcard `_` is used
