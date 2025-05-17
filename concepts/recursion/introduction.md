# Introduction

Recursive functions are functions that call themselves.

A recursive function needs to have at least one _base case_ and at least one _recursive case_.

A _base case_ returns a value without calling the function again.
A _recursive case_ calls the function again, modifying the input so that it will at some point match the base case.

In Elm, recursive functions are typically defined using pattern matching with `case` expressions or multiple function clauses.

```elm
count : List a -> Int
count list =
    case list of
        [] ->
            0  -- base case

        _ :: tail ->
            1 + count tail  -- recursive case
```

## Loops through recursion

Due to immutability, loops in Elm are written differently from imperative languages.
For example, loops commonly look like:

```c
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

In practice, iterating over lists and other data structures in Elm is most often done using functions from the `List` module, such as `List.map`, `List.filter`, and `List.foldl`.
Under the hood, these functions are implemented using recursion.
