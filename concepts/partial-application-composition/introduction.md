# Introduction

## Partial application

All functions in Elm are [curried][currying], which means that if you call a function without passing all of the arguments, it returns a new function.

The result of doing this is called [partial-application][partial-application] (you are not passing all the arugments to the function, but are partially applying some of them).

```elm
add2 = add 2
--> Int -> Int

eigth = add2 6
--> 8
```

Partial application always applies the arguments in order.

```elm
-- contains: String -> String -> Int
-- contains first second =
--> This function is in the standard library, and returns True if the second string contains the first one

containsCedd = contains "Cedd"
--> String -> Bool
--> (partial application always applies the arguments in order, so "Cedd" becomes the first argument to contains
--> This is a function that takes a string, and returns True if that string contains Cedd)

containsCedd "-Cedd-"
--> True
--> ("-Cedd-" ends up being the second argument to contains, and it does include "Cedd", the first argument)
```

## Pipe operator (`|>`)

Saying `x |> f` is exactly the same as `f x`. A concrete example is `"5" |> String.toInt` is the same as `String.toInt "5"`.

This doesn't sound very useful at first, but it is called the [pipe operator][pipe-operator] because it lets you write “pipelined” code.

For example, say we have a sanitize function for turning user input into integers:

```elm
sanitize : String -> Maybe Int
sanitize input =
    String.toInt (String.trim input)
```

We can rewrite it like this:

```elm
sanitize : String -> Maybe Int
sanitize input =
    input
    |> String.trim
    |> String.toInt
```

This avoids the use of brackets, and shows the functions in the order that they are applied (first `String.trim`, then `String.toInt`), which aids readability.

There is also a [reverse pipe operator `(<|)`][reverse-pipe-operator].
Saying `x <| f` is exactly the same as `f x`.
This doesn't look very useful at first glance either, and is definitely not used as much as the pipe operator, but it helps to avoid brackets in some situations.

## Function composition / point free style

The [`(>>)`][forward-composition] operator has the type `(a -> b) -> (b -> c) -> (a -> c)` and creates a function of type `a -> c`  by composing two compatible functions of type `a -> b `and `b -> c`.
It does this by taking the output (of type `b`) from the first function and using it as the first argument to the second function (which must be of the same type `b`).
The created function will take the same input (of type `a`) first function, and will return whatever `c` the second function returns.

A concrete example is `String.trim >> String.toInt`.
`String.trim` takes a string as its only parameter, so this is what the created function takes.
`String.toInt` returns a `Maybe Int`, so this is what the created function returns.
`String.trim` returns a `String`, which `String.toInt` accepts as a parameter, so the example compiles.

We can now rewrite our `sanitize` function as follows:

```elm
sanitize : String -> Maybe Int
sanitize =
    String.trim >> String.toInt
```

Note that we no longer use the `input` parameter that you can see the original example, even though the functionality is identical.
This way of creating functions that make no reference to their parameters is called "Point Free Style".
The advantage of this style is that the code is more concise, the disadvantage is that it can be harder to understand, especially for beginners.

It is worth remembering that all functions are curried in Elm, so `String.length >> max` compiles, and results in the following:

- A function (1) that has a string parameter (the input to `String.length`)
- `max` is a function that has two `Int` parameters, but function 1 passes a single `Int` to it (the return from `String.length`) so `max` is partially applied.
- The return value of the partially applied `max` function, is another function (2) that takes an `Int`, and returns the largest of this `Int` and the partially applied `Int` from `String.length`
- Hence function 1 (`String -> Int`) returns function 2 (`Int -> Int`)
- So `((String.length >> max) "123") 2` returns `3`, because `"123"` has a length of 3, which is greater than the 2 from the `Int` argument.

## Function design

To make it easy to write elegant code in Elm, you should make the main data structure the last parameter of functions.
All the common functions in the standard library do this, such as `List.map` (type signature below).

```elm
map : (a -> b) -> List a -> List b
```

Here we can see that the last parameter to the `map` function is `List a` and it returns `List b`, so the main data structure (`List`) is the last parameter.

This makes it possible to write elegant pipelined code, such as below.

```elm
trimAndUpperCase : List String -> List String
trimAndUpperCase names =
    names
    |> List.map String.trim
    |> List.map String.toUpper
```

It also makes it convenient to use function composition and point free style, as an alternative to pipelining.

```elm
trimAndUpperCase : List String -> List String
trimAndUpperCase =
    List.map String.trim
    >> List.map String.toUpper
```

Function composition also allows you to reduce this example to a single call to `List.map`.

```elm
trimAndUpperCase : List String -> List String
trimAndUpperCase =
    List.map (String.trim >> String.toUpper)
```

[currying]: https://www.bekk.christmas/post/2020/9/hurry-curry!
[partial-application]: https://www.bekk.christmas/post/2020/10/partial-application-of-functions!
[pipe-operator]: https://package.elm-lang.org/packages/elm/core/latest/Basics#|%3E
[reverse-pipe-operator]: https://package.elm-lang.org/packages/elm/core/latest/Basics#%3C|
[forward-composition]: https://package.elm-lang.org/packages/elm/core/latest/Basics#%3E%3E
[backward-composition]: https://package.elm-lang.org/packages/elm/core/latest/Basics#%3C%3C
