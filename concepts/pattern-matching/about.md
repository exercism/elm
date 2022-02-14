# Introduction

[Pattern matching][pattern-matching] enables expressive branching code and [destructuring][destructuring] brings elegant binding of values to variables.
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
        -- here we don't care about the data held by 'Friend'
        Friend _ -> "Hi!"
        -- mandatory because pattern matching must be exhaustive,
        -- but for all other cases, we answer the same thing
        _ -> "Hello stranger!"
```

## Advanced pattern matching

In addition to custom types, we can also pattern match on types that have literals, such as `Char`, `String`, `Int` and `Floats`.

```elm
howMany : Int -> String
howMany count =
    case count of
        0 -> "none!"
        1 -> "there is one!"
        2 -> "a couple!"
        _ -> "too many to count!"

greekLetter : String -> String
greekLetter letter =
    case letter of
        "a" -> "alpha"
        "b" -> "beta"
        _ -> "I don't remember"
```

For matching more than one value without nesting, a common Elm trick is to combine the values to match in [_ad hoc tuples_][ad-hoc-tuples] like so:

```elm
howManyGreekLetters : Int -> String -> String
howManyGreekLetters count letter =
    case ( count, letter ) of
        ( 0, _ ) -> "none!"
        ( 1, "a" ) -> "there is an alpha!"
        ( 1, "b" ) -> "there is a beta!"
        _ -> "at least two!"
```

And since lists are dear to functional programmers, [they can also be pattern matched on][pattern-match-lists], with the same syntax that is used to build them, using the operator `::`.

```elm
head : List a -> Maybe a
head list =
    case list of
        [] -> Nothing
        x :: _ -> Just x
```

Finally, pattern matching even works recursively, enabling deep dives into complex and recursive types.

```elm
type Activity = Work | Play Game
type Game = Boardgame String | VideoGame String

pickActivity : Activity -> Bool
pickActivity activity =
    case activity of
        -- The only thing we want is playing Catan
        Play (Boardgame "Catan") -> True
        _ -> False
```

## Destructuring

Destructuring is very similar to pattern matching in the sense that it enables binding of variables to data inside types.
The main difference is that we call that mechanism "destructuring" when there is only one shape possible, and we call it pattern matching for multiple shapes.
Destructuring is often found in `let` bindings, in function arguments, and of course in case expressions, mixed with pattern matching.

```elm
pairSum : ( Int, Int ) -> Int
pairSum pair =
    -- Destructuring of a pair in a 'let' binding
    let ( x, y ) = pair
    in x + y

-- Custom type containing a single variant
type Container = Box String

-- Destructuring of the container as function argument
-- to bind its content directly without the need of 'let' or 'case'.
unbox : Container -> String
unbox (Box str) =
    str

-- Destructuring combined with pattern matching
unboxMaybe : Maybe Container -> Maybe String
unboxMaybe maybeContainer =
    case maybeContainer of
        Nothing -> Nothing
        Just (Box "42") -> Just "The answer to the universe!"
        Just (Box str) -> Just str
```

Destructuring can be used for single variant custom types, for tuples, and also for records, where it is very convenient.
To [destructure a record][records-pattern-matching], one can use any number of its fields, one, two, ..., or all the fields.

```elm
type alias Circle =
    { radius : Float
    , center : ( Float, Float )
    }

perimeter : Circle -> Float
perimeter { radius } =
    2 * pi * radius
```

Unfortunately, the elm syntax does not enable recursive destructuring of records.
In the previous `Circle` example, there is no way to access the `x`` and `y positions of the circle center in one go.
We must first access the `center` and then destructure it for its `x` and `y` positions.

```elm
left : Circle -> Float
left { radius, center } =
    let ( x, _ ) = center
    in x - radius
```

And we have one last tip!
Sometimes we want easy access to both a thing as a whole and a part of it.
This is where the [`as` keyword][as-keyword] can be useful.
It enables giving an alias name to a thing as a whole, while still being able to destructure its content.

```elm
-- Make the circle smaller if the radius is sufficiently big.
-- Otherwise, return the circle unchanged.
smaller : Float -> Circle -> Circle
smaller reduction ({ radius, center } as circle) =
    if reduction < radius then
        { radius = radius - reduction
        , center = center
        }
    else
        circle
```

[pattern-matching]: https://guide.elm-lang.org/types/pattern_matching.html
[destructuring]: https://gist.github.com/yang-wei/4f563fbf81ff843e8b1e
[records-pattern-matching]: https://elm-lang.org/docs/records#pattern-matching
[as-keyword]: https://github.com/izdi/elm-cheat-sheet#operators
[pattern-match-lists]: https://www.bekk.christmas/post/2020/8/peeking-inside-lists
[ad-hoc-tuples]: https://www.bekk.christmas/post/2020/7/simplify-your-code-with-ad-hoc-tuples