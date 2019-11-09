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

Pascal's Triangle at Wolfram Math World [http://mathworld.wolfram.com/PascalsTriangle.html](http://mathworld.wolfram.com/PascalsTriangle.html)

## Submitting Incomplete Solutions

It is possible to submit an incomplete solution so you can see how others have
completed the exercise.
