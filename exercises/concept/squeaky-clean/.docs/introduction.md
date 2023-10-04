# Introduction

## Chars

The `Char` type represents the smallest addressable components of text.
Multiple `Char`s can comprise a string such as `"word"` or they can be
processed independently. Their literals have single quotes e.g. `'A'`.

Elm `Char` and `String` support Unicode encoding so in addition to the latin character set pretty much all the writing systems in use can be represented, e.g. the Greek letter `'β'`.

There are many builtin functions to inspect and manipulate `Char`s and `String`. 

## Strings

`Char`s are most often used in conjunction as part of the `String` type.
This module has many functions that allow a string to be constructed
character by character and manipulated.
