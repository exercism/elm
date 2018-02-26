# Pascal's Triangle

Compute Pascal's triangle up to a given number of rows.

In Pascal's Triangle each number is computed by adding the numbers to
the right and left of the current position in the previous row.

```text
    1
   1 1
  1 2 1
 1 3 3 1
1 4 6 4 1
# ... etc
```

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

Pascal's Triangle at Wolfram Math World [http://mathworld.wolfram.com/PascalsTriangle.html](http://mathworld.wolfram.com/PascalsTriangle.html)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
