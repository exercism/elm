# Introduction

Pattern matching enables expressive branching code and destructuring brings elegant binding of values to variables.
Both are extremely useful to master as elm programmers, and when used together, they greatly improve code readibility.

## Simple pattern matching

Pattern matching denotes branching code depending on the shape of the manipulated data.
It thus naturally fits with the concept of custom types, which express the multiple shapes that some data can take.
Given a `Color` custom type defined as being either `Blue` or `Red` for example, we can write a `toString` function, pattern matching on the color to return the correct string.

```elm
type Color = Blue | Red

toString : Color -> String
toString color =
    case color of
        Blue -> "blue"
        Red -> "red"
```

Pattern matching also works for custom types that are not simple enumeration.
Let's consider a `hello` function, taking as parameter a `Maybe String`, holding either a person name or nothing at all.
When pattern matching, we can give lower case names to data to bind that data to that variable, and be able to use it in the right-hand side of the match.

```elm
hello : Maybe String -> String
hello maybeName =
    case maybeName of
        Nothing -> "Hello stranger!"
        -- here we bind 'name' to the data inside the 'Just'
        Just name -> "Hello " ++ name ++ "!"
```

Pattern matching must be exhaustive, otherwise the compiler will refuse to compile.
But sometimes, we don't care about some data or about some branches of a case expression.
In those cases, instead of having to find a variable name to bind and having branches for all cases, we can use the underscore wildcard `_`.

```elm
type Entity = Friend { name: String } | Stranger | Alien

hello : Entity -> String
hello entity =
    case entity of
        -- here we don't care about the data holded by 'Friend'
        Friend _ -> "Hi!"
        -- mandatory because pattern matching must be exhaustive,
        -- but for all other cases, we answer the same thing
        _ -> "Hello stranger!"
```

## Advanced pattern matching

- Know how to use literals in pattern matching.
- Know how to pattern match recursively.
- Know how to use `as` in pattern matching.

## Destructuring

- Know how to destructure in case expressions.
- Know how to destructure in function arguments.
- Know how to destructure in assignments.
- Know the naming limitations of destructuring records.
