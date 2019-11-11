# Pythagorean Triplet

A Pythagorean triplet is a set of three natural numbers, {a, b, c}, for
which,

```text
a**2 + b**2 = c**2
```

and such that,

```text
a < b < c
```

For example,

```text
3**2 + 4**2 = 9 + 16 = 25 = 5**2.
```

Given an input integer N, find all Pythagorean triplets for which `a + b + c = N`.

For example, with N = 1000, there is exactly one Pythagorean triplet for which `a + b + c = 1000`: `{200, 375, 425}`.

## Elm Installation

Refer to the [Installing Elm](https://exercism.io/tracks/elm/installation) page
for information about installing elm.

## Writing the Code

The code you have to write is located inside the `src/` directory of the exercise.
Elm automatically installs packages dependencies the first time you run the tests
so we can start by running the tests from the exercise directory with:

```bash
$ elm-test
```

To automatically run tests again when you save changes:

```bash
$ elm-test --watch
```

As you work your way through the tests suite in the file `tests/Tests.elm`,
be sure to remove the `skip <|`
calls from each test until you get them all passing!

## Source

Problem 9 at Project Euler [http://projecteuler.net/problem=9](http://projecteuler.net/problem=9)

## Submitting Incomplete Solutions

It is possible to submit an incomplete solution so you can see how others have
completed the exercise.
