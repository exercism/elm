# Logical expression

```elm
isLeapYear : Int -> Bool
isLeapYear year = 
  let
    divisbleBy number = 
      modBy number year == 0 
  in
    divisibleBy 4 && (not (divisibleBy 100) || divisibleBy 400)
```

We can combine smaller logical statements into larger ones using the logical operators `&&` (and), `||` (or), and `not` (negation).

A logicial expression is the most concise approach.

## Precedence

In school they teach you that `2 + 3 * 4` is to be read as meaning `2 + (3 * 4)`.
This is a convention, chosen for its convenience.
We say that the `*` operator has _higher [precedence][precedence]_ than `+`.

In logic similar ambiguities exist, and these are similarly resolved.

- _and_ has higher precedence than _or_, and
- _not_ has higher precedence than both _and_ and _or_.

For example, `p || q && r` means the same as `p || (q && r)`.

If you don't wish to remember the precendence of all the things, or force readers of your code to do so, you can use parentheses to make it explicit.

[precedence]:
    https://en.wikipedia.org/wiki/Order_of_operations
    "Wikipedia: Order of operations"
