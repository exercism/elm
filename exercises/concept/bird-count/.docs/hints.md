# Hints

## General

- Read about [recursion from the creator of Elm][recursion].
- Use pattern matching with `case` expressions.
- Try to split a problem into a base case and a recursive case. For example, let's say you want to count how many cookies are there in the cookie jar with a recursive approach. A base case is an empty jar - it has zero cookies. If the jar is not empty, then the number of cookies in the jar is equal to one cookie plus the number of cookies in the jar after removing one cookie.

## 1. Check how many birds visited today

- This task doesn't need recursion.
- Accessing the first element in a list can be done by pattern matching with a `case` expression.
- Remember to wrap the result in `Just` when returning a value.

## 2. Increment today's count

- This task doesn't need recursion.
- Accessing the first element in a list can be done by pattern matching with a `case` expression.
- Use the [`::` operator][list-cons] to deconstruct and reconstruct the new list.

## 3. Check if there was a day with no visiting birds

- Use recursion to iterate over elements in the list until a day with no visiting birds is found.
- The base cases are an empty list or a day without bird.
- Use pattern matching to check for `0` in the list.

## 4. Calculate the total number of visiting birds

- Use recursion to iterate over every element in the list.
- The base case is an empty list.
- Use the `+` operator to add the current element to the total of the rest.

## 5. Calculate the number of busy days

- Use recursion to iterate over every element in the list.
- The base case is an empty list.
- Use an `if` expression to check if the current day is busy (5 or more birds).
- Add 1 to the count of busy days in the rest of the list when a busy day is found.

[list-cons]: https://package.elm-lang.org/packages/elm/core/latest/List#(::)
[recursion]: https://functional-programming-in-elm.netlify.app/recursion/
