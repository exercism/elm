# Design

## Goal

The students will learn to generate random values through the use of generators.

## Learning objectives

Students will be able to

- Explain the general idea of a `Generator`
- Explain why a pure language can't use `math.random()`
- Use primitive generators: `int`, `float`, `uniform`, `weighted`, `constant`
- Combine them with data structures: `pair`, `list`
- Modify generators with `map`, `mapN`, `andThen`
- Know to use `lazy` for recursive applications
- Look up more helpers in `elm-community/random-extra`

## Out of scope

- Using `generate` (we can only mention because it returns a `Cmd msg`)
- Generate values: `Seed`, `step`, `initialSeed` (only mentioned, not used)
- `independentSeed`
- `maxInt`, `minInt`

## Concepts

The concepts this exercise unlock are:

- random

## Prerequisites

- basics-1
- basics-2
- tuples
- lists
- custom-types

## Analyzer

Make sure that:

- `room` uses `treasure`
- `maze` uses `deadend`, `branch` and `room`
- `maze` uses `maze` recursively
- `mazeOfDepth` uses `deadend`, `branch` and `room`
- `mazeOfDepth` uses `mazeOfDepth` recursively
