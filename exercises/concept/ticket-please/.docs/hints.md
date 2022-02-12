# Hints

## General

- Read about [pattern matching][pattern-matching] in the official guide.
- Have a look at this cheat-sheet about [destructuring][destructuring].
- Pattern matching for records is [explained here][records-pattern-matching] in more details.

## 1. Detect empty comments

- You can use `(a, b)` directly in the function argument if the argument is a pair.
- You can replace values that you receive but don't use by the wildcard `_`.
- To check if a string is empty, check the [`String` documentation][string-docs].

## 2. Count the number of comments from the creator

- You can destructure a custom type with a single variant `type Box = Box AB` directly in a function argument like so: `(Box ab)`.
- You can pattern match the field `a` of a record `{a : A, b : B}` using: `{ a }`.
- You can use both the above techniques at the same time for custom types that hold a record.
- You cannot directly pattern match the pair `ab` from a record `{ ab : (A, B) }`. You must pattern match `{ ab }` first, then use `( a, b) = ab` in a `let` binding.
- To find the number of elements that satisfy a condition in a list, use [`List` functions][list-docs].
- You can destructure pairs diectly in anonymous functions arguments.

## 3. Detect tickets assigned to the Dev Team

- Like in Task 2, you can match relevant fields of a "boxed" record in the function argument.
- You can use patten matching recursively to match a nested value like `Just (Box "42")`.
- You can use the wildcard `_` to match anything in a `case` statement. 

## 4. Assign tickets to IT employees

- Like in Tasks 2 and 3, you can match relevant fields of a "boxed" record in the function argument.
- Additionaly, you can use the `as` keyword to pattern match a field and also bind the whole record: `(Box ({ a } as ab))`.
- You can pattern match the values of a custom type with the `case` statement.
- Use the type contructor `Ticket` to return a ticket.
- Use the [record update syntax][record-update] to modify records.

[pattern-matching]: https://guide.elm-lang.org/types/pattern_matching.html
[destructuring]: https://gist.github.com/yang-wei/4f563fbf81ff843e8b1e
[records-pattern-matching]: https://elm-lang.org/docs/records#pattern-matching
[string-docs]: https://package.elm-lang.org/packages/elm/core/latest/String
[list-docs]: https://package.elm-lang.org/packages/elm/core/latest/List
[record-update]: https://elm-lang.org/docs/records#updating-records