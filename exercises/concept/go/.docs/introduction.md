# Introduction

## Result

The `Result` type is the solution in the Elm language for error reporting and an enabler for error recovery. It is somewhat similar to the `Maybe` type, but where Maybe can be returned by functions that may fail, it doesn't tell you anything about why it failed. Result includes this context about why something failed.

The `Result` type is defined as follows:

```elm
type Result error value
  = Ok value
  | Err error
```

This is known as a "custom type" definition in Elm terminology.
The `error` and `value` in `OK value` and `Error error` represent a type variable, meaning it can be any type, such as `Int`, `Bool` or `String`.
As such, a `Result String Int` is a variable that is expected to contain an `Int`, and if there is an error this will be represented as a `String`.
There is a [Result module](https://package.elm-lang.org/packages/elm/core/latest/Result) with lots of useful helper functions for result.
