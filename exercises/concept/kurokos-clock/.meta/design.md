# Design

## Goal

The Goal is to learn to use the `Time` module.
We need to make it very clear that that module by itself is not enough to handle complex date and time tasks, but it merely a tool to display a time provided by the browser. More complex uses are done with packages.

## Learning objectives

Students should be able to

- understand what POSIX time means
- transform `Posix` into millisecond `Int` back and forth (`posixToMillis`, `millisToPosix`)
- use different time zones to show the time in different locales (`utc`)
- display the date and time from a Posix in a specific time zone (`toX`, `Month`)
- display the week day of a given Posix (`toWeekday`, `Weekday`)

## Out of scope

- functions that use the runtime (`now`, `every`, `here`) although they can be mentioned
- time manipulation (adding or removing duration...)
- Elm packages for time manipulation, although it should be mentioned that it's the practical/idiomatic approach
- custom time zone functions (we can use `customZone` for exercises)

## Concepts

The concept this exercise unlocks is:

- `time`

## Prerequisites

- `strings`
- `custom-types`
- `pattern matching`

## Analyzer

- [essential] `showDateTime` should be using `showLocalDate` and `showLocalTime`
