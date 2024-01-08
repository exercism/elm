# Case expression

```elm
isLeapYear : Int -> Bool
isLeapYear year =
  let
    isDivisibleByFour = (modBy 4 year) == 0
    isDivisibleBy100 = (modBy 100 year) == 0
    isDivisibleBy400 = (modBy 400 year) == 0
  in
    case (isDivisibleByFour, isDivisibleBy100, isDivisibleBy400) of
      (True, _, True) -> True
      (True, False, _) -> True
      _ -> False
```

## In this approach

In this approach we use a [`case` expression][case-expression], and match on a [`Tuple`][tuple]
It turns out that, if we are careful to ask questions in the right order, we can always potentially attain certainty about the answer by asking one more question.
This is a [truth-table][truth-table] like approach, which can be easier to read for complicated logic.

## When to use a case expression?

Using a case expression with a `Tuple` is idiomatic in Elm, but Tuple's have a maximum of 3 values, so can't be used for anything larger than this.

Strings and arrays can hold more values and can also be used with case expressions, which are useful in many circumstances.
Using an array with a case expression and recursion is especially common.

[case-expression]:
  https://elmprogramming.com/case-expression.html
  "case expressions in Elm"
[tuple]
  https://elmprogramming.com/tuple.html
  "Tuples in Elm"
[truth-table]:
  https://brilliant.org/wiki/truth-tables/
  "Truth tables"
