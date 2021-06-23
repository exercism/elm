# Introduction

The `Maybe` type is the solution in the Elm language for optional values.
It is thus present in type signatures of a wide number of core Elm functions and understanding it is crucial.
The `Maybe` type is defined as follows:

```elm
type Maybe a = Nothing | Just a
```

This is known as a "custom type" definition in Elm terminology.
The vertical bar `|` in the type definition of `Maybe` means "OR".
It indicates that it can either be `Nothing` OR be `Just` something.
Creating a `Maybe` value is done via one of its two constructors `Nothing` and `Just`.
Reading the content of a `Maybe` is done via pattern matching.
