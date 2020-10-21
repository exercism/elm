# Exercism Elm Track
[![build status](https://github.com/exercism/elm/workflows/elm%20%2F%20master/badge.svg)]

Exercism Exercises in Elm

## Track Organization

The track is organized with the following main directories and files:
```
bin/          # executables required to manage the track
config/       # configuration files for the track
docs/         # documentation files for automatically generated web pages on exercism.io
exercises/    # contains one directory per exercise
template/     # template used when generating a new exercise
.travis.yml   # Travis automatic build and tests configuration
config.json   # configuration file for all exercises metadata
package.json  # Node package configuration required for running builds and tests
```
Each exercise within the `exercises/` directory has the following structure:
```
src/                   # directory for elm source files
  Exercise.elm         # template downloaded by students
  Exercise.example.elm # example solution for this exercise
tests/
  Tests.elm            # test file as downloaded by students
README.md              # generated readme (do not edit by hand)
elm.json               # elm json config file
```

## Contributing

We welcome contributions of all sorts and sizes,
from reporting issues to submitting patches or implementing missing exercises.
Please read first [Exercism contribution guidelines][contributing].
If you are not familiar with git and GitHub,
you can also have a look at [GitHub's getting started documentation][github-start].

[contributing]: https://github.com/exercism/problem-specifications/blob/master/CONTRIBUTING.md
[github-start]: https://help.github.com/en/github/getting-started-with-github

### Setup

In order to contribute code to this track, you need to have already installed
[npm][npm-install], [elm][elm-install], [elm-test][elm-test], and [elm-format][elm-format].
The build and tests script for this track lives at `bin/build.sh`.
It uses the locally installed versions of elm, elm-test and elm-format,
specified in the `package.json` file.
Thus you can run `bin/build.sh` without the need of having those installed globally
but it will be quite inconvenient when working on single exercises.

[npm-install]: https://docs.npmjs.com/downloading-and-installing-node-js-and-npm
[elm-install]: https://guide.elm-lang.org/install/elm.html
[elm-test]: https://www.npmjs.com/package/elm-test
[elm-format]: https://github.com/avh4/elm-format

### Preparing for v3 of Exercism

If you are interesting in investing mid-term and long-term energy into this project,
have a look at [issue #280][v3-issue].

[v3-issue]: https://github.com/exercism/elm/issues/280

### Adding Missing Exercise

All tracks share a common pool of exercises specified in
[exercism/problem-specifications][problem-spec] repository.
You can find a list of all missing exercises on [tracks.exercism.io][missing-exercises].
Please read first [Exercism documentation about implementing an exercise][impl-exercise].

[problem-spec]: https://github.com/exercism/problem-specifications
[missing-exercises]: https://tracks.exercism.io/elm/master/unimplemented
[impl-exercise]: https://github.com/exercism/docs/blob/master/you-can-help/implement-an-exercise-from-specification.md

Before you start implementing a missing exercise, make sure your setup is already working.
```sh
bin/fetch-configlet # if not already retrieved
bin/configlet lint .
bin/build.sh
```

Then, the general steps for implementing a missing exercise are the following.

1. Run the command `bin/stub-new-exercise.sh <exercise-slug>`
2. Move into that exercise directory
3. Replace placeholder names in `src/` and `tests/`, rename `src/<exercise>.elm` accordingly
4. Run `elm-test` to verify that everything is setup correctly
5. Complete tests according to the `canonical-data.json` file of the exercise in [exercism/problem-specifications][problem-spec]
6. Complete implementation of the solution in `src/<exercise>.elm` and check it passes all tests.
7. Prepare files such that they are ready for student use:
   * Rename `<exercise>.elm` into `<exercise>.example.elm`
   * Prepare a starter file for students named `<exercise>.elm`. That is what `exercise download` will retrieve
   * Add `skip <|` to all tests except the first one so that students can progress gradually
8. Update `config.json` file with an entry for this exercise.
   * Explanations regarding this file are provided in [Exercism documentation][exercise-config]
   * The uuid should be generated with the command `bin/configlet uuid`
9. Check that everything is configured correctly and that builds pass
   by running `bin/configlet lint .` and `bin/build.sh` from the root of the directory
10. Yeah! you can submit your PR

[exercise-config]: https://github.com/exercism/docs/blob/master/language-tracks/configuration/exercises.md

### Make Up New Exercises

Follow [instructions on Exercism documentation][new-exercise].

[new-exercise]: https://github.com/exercism/docs/blob/master/you-can-help/make-up-new-exercises.md

## Elm icon

We were unable to find copyright information about the Elm logo,
nor information about who designed it.
Presumably Evan Czaplicki, creator of the Elm language,
also made the logo, and holds copyright.
It may also fall within the public domain, since it is a geometric shape.
We've adapted the official Elm logo by changing the colors, which we believe falls under "fair use".
