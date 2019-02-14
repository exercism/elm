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

Refer to the [Installing Elm](https://exercism.io/tracks/elm/installation) page
for information about installing elm.

## Writing the Code

The first time you start an exercise, you'll need to ensure you have the
appropriate dependencies installed. Thankfully, Elm makes that easy for you and
will install dependencies when you try to run tests or build the code.

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

It is possible to submit an incomplete solution so you can see how others have
completed the exercise.
