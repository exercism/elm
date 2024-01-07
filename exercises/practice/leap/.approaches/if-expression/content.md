# If expresion

```elm
isLeapYear : Int -> Bool
isLeapYear year =
  let
    divisbleBy number = 
      modBy number year == 0 
  in
    if divisbleBy(400) then
      return True
    
    else if divisbleBy(100) then
      return False
    
    else if divisbleBy(4) then
      return True
    
    else
      return False

```

An _if expression_ (`if … then … else …`) is a compound expression that uses a test to determine which of two alternatives to evaluate to.
Many other languages feature a similar construct, often termed 'ternary operator'.

## In this approach

This approach uses exactly two tests to determine whether a year is a leap year.

The first test is for divisibility by 100.
Once we know if the year is a multiple of 100, we know which further test to perform.

- If the year is evenly divisible by 100, then `divisibleBy 100` will evaluate to `True` and the entire `if` expression will evaluate to whatever `divisibleBy 400` evaluates to.
- If the year is _not_ evenly divisible by 100, then `divisibleBy 100` is `False` and so the `if` expression evaluates to `divisibleBy 4`.

## When to use `if`?

`if` expressions might be a good fit when you

- need an expression that
- chooses between exactly two options
- depending on a single `Bool`.

When you have something other than a `Bool`, use `case` instead.
