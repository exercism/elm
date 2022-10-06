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
-- This function is in the standard library, and returns True if the second string contains the first one

-- partial application always applies the arguments in order, so "Cedd" becomes the first argument to contains
-- This is a function that takes a string, and returns True if that string contains cedd
containsCedd = contains "Cedd"
--> String -> Bool

-- "-Cedd-" ends up being the second argument to contains, and it does include "Cedd", the first argument
containsCedd "-Cedd-"
--> True
```

## Pipe operator (`|>`)

Saying x |> f is exactly the same as f x. A concrete example is `"5" |> toInt` is the same as `toInt "5"`

This doesn't sound very useful, but it is called the [pipe operator][pipe-operator] because it lets you write “pipelined” code.

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

This avoids the use of brackets, and shows the functions in the order that they are applied (first String.trim, then String.toInt), which aids readability.

There is also a [reverse pipe operator (<|)][reverse-pipe-operator]. Saying x <| f is exactly the same as f x. This doesn't look very useful at first glance, and is definitely not used as much as the pipe operator, but it still helps to avoid brackets in some situations.

[currying]: https://www.bekk.christmas/post/2020/9/hurry-curry!
[partial-application]: https://www.bekk.christmas/post/2020/10/partial-application-of-functions!
[forward-pipe-operator]: https://package.elm-lang.org/packages/elm/core/latest/Basics#|%3E
[reverse-pipe-operator]: https://package.elm-lang.org/packages/elm/core/latest/Basics#%3C|
