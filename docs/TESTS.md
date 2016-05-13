Elm exercises within your exercism project directory can be run by changing to the exercise directory, and running `./runtests.sh` (or `runtests.bat` on Windows).

```bash
$ cd exercism/project/directory/elm/hello-world
$ ./runtests.sh
```

## Hints and tips

### Coding the exercise

The README.md for each exercise gives a general description but the Elm test program will be very specific. Open the test program and give it a quick look - if it seems like cheating, do it anyway. Look for helpful comments, test data, and just the names of the test functions. Try running the test command before you have written anything and see if the error messages give you an idea of where to start.

Your first goal it to get something to compile, even though it fails tests. For this, you should "stub" functions. That means leave the body empty, except for whatever it must return. Write something like `myFunc param = 0` or whatever it takes just to get it to compile. Sometimes to figure out function types you will have to go back to the test program and read in more detail. Once you have figured out all the required function signatures, the test program will complain that `0` is the wrong answer. Now start filling in function bodies.

### Fixing

It will often be helpful to focus on the first failing test. Fix that one, repeat until no errors. Compile errors and warnings will produce lots of helpful output.

### Cleaning up your code

Consider running [`elm-format`](https://github.com/avh4/elm-format) on your code before submitting it.
