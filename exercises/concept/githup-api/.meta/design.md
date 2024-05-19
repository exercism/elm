# Design

## Goal

The Goal is to learn to use the `Json.Decode` and `Json.Encode` modules.

## Learning objectives

Students should be able to

- encode any JSON `Value` (`Json.Encode.object`, `list` and other primitives)
- prettify a value (`encode`)
- understand why decoders are useful even though the concept is unusual
- decode JSON primitives (`bool`, `int`, `string`, `null`...)
- decode data structures (`list`, `dict`, `nullable`)
- decode objects (`field`)
- deal with uncertainty (`maybe`, `oneOf`)
- modify and chain decoders (`map`, `andThen`, `succeed`, `fail`)
- run a decoder on a string input (`decodeString`)

## Out of scope

- encoder aliases (`array`, `set`)
- more niche decoders (`array`, `keyValuePairs`, `oneOrMore`, `index`, `at`, `value`)
- dealing with `Error`
- decoding recursive structures (`lazy`, a quick mention is fine)

## Concepts

The concept this exercise unlocks is:

- `json`

## Prerequisites

- strings
- lists
- dict
- records
- maybe
- custom-types

## Analyzer

- ?
