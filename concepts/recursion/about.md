# About

Recursive functions are functions that call themselves.

A recursive function needs to have at least one _base case_ and at least one _recursive case_.

A _base case_ returns a value without calling the function again.
A _recursive case_ calls the function again, modifying the input so that it will at some point match the base case.

In Elm, recursive functions are typically defined using pattern matching with `case` expressions.

```elm
count : List a -> Int
count list =
    case list of
        [] ->
            0  -- base case

        _ :: tail ->
            1 + count tail  -- recursive case
```

A recursive function can have many base cases and/or many recursive cases.
For example [the Fibonacci sequence][fibonacci] is a recursive sequence with two base cases:

```elm
fibonacci : Int -> Int
fibonacci n =
    case n of
        0 ->
            0

        1 ->
            1

        _ ->
            fibonacci (n - 1) + fibonacci (n - 2)
```

Counting the number of occurrences of some given value `x` in a list has two recursive cases:

```elm
countOccurrences : List a -> a -> Int
countOccurrences list x =
    case list of
        [] ->
            0

        head :: tail ->
            if head == x then
                1 + countOccurrences tail x
            else
                countOccurrences tail x
```

## Loops through recursion

Due to immutability, loops in Elm are written differently from imperative languages.
For example, loops commonly look like:

```
for(i = 0; i < array.length; i++) {
  // do something with array[i]
}
```

In a functional language like Elm, mutating variables is not possible.
Thus, loops have to be implemented with recursion.

The equivalent of a `for` loop in Elm would look like this:

```elm
loop : List a -> (a -> b) -> List b
loop list f =
    case list of
        [] ->
            []

        head :: tail ->
            f head :: loop tail f
```

In practice, iterating over lists and other data structures in Elm is most often done using functions from the [`List`][module-list] module, such as `List.map`, `List.filter`, and `List.foldl`.
Under the hood, these functions are implemented using recursion.

## Infinite execution

Recursive functions, if implemented incorrectly, might never return their result.
This can be problematic because each time a function is called, a reference is stored in memory where the runtime should return the result (on the [call stack][wiki-call-stack]).
If a recursive function calls itself infinitely, it is possible to run out of memory causing the runtime to crash (a [stack overflow error][wiki-stack-overflow]).
Elm's runtime is optimized for recursion and reliability, but infinite recursion can still cause issues.

This problem of infinite execution can be caused by:

- Forgetting to implement a base case.
- Not handling all possible cases in pattern matching.
- Not modifying the argument properly when doing the recursive call, and thus never reaching the base case.

[fibonacci]: https://en.wikipedia.org/wiki/Fibonacci_number
[module-list]: https://package.elm-lang.org/packages/elm/core/latest/List
[wiki-call-stack]: https://en.wikipedia.org/wiki/Call_stack
[wiki-stack-overflow]: https://en.wikipedia.org/wiki/Stack_overflow
