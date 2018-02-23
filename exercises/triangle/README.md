# Triangle

Determine if a triangle is equilateral, isosceles, or scalene.

An _equilateral_ triangle has all three sides the same length.

An _isosceles_ triangle has at least two sides the same length. (It is sometimes
specified as having exactly two sides the same length, but for the purposes of
this exercise we'll say at least two.)

A _scalene_ triangle has all sides of different lengths.

## Note

For a shape to be a triangle at all, all sides have to be of length > 0, and
the sum of the lengths of any two sides must be greater than or equal to the
length of the third side. See [Triangle Inequality](https://en.wikipedia.org/wiki/Triangle_inequality).

## Dig Deeper

The case where the sum of the lengths of two sides _equals_ that of the
third is known as a _degenerate_ triangle - it has zero area and looks like
a single line. Feel free to add your own code/tests to check for degenerate triangles.

## Elm Installation

Refer to the [Exercism help page](http://exercism.io/languages/elm) for Elm
installation and learning resources.

## Writing the Code

The first time you start an exercise, you'll need to ensure you have the
appropriate dependencies installed.

```bash
$ elm-package install --yes
```

Execute the tests with:

```bash
$ elm-test
```

Automatically run tests again when you save changes:

```bash
$ elm-test --watch
```

As you work your way through the test suite, be sure to remove the `skip <|`
calls from each test until you get them all passing!

## Source

The Ruby Koans triangle project, parts 1 & 2 [http://rubykoans.com](http://rubykoans.com)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
