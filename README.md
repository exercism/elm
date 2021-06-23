# Exercism Elm Track

![build status](https://github.com/exercism/elm/workflows/elm%20%2F%20master/badge.svg)
![configlet](https://github.com/exercism/elm/workflows/configlet/badge.svg)

This is the Elm track, one of the many tracks on [Exercism][web-exercism].
It holds all the Elm _Concepts_, _Concept Exercises_ and _Practice Exercises_ that are currently implemented and available for students to complete.
They are all listed in the [`config.json`][config-json] track config file.
This readme file is mainly targeted at people wishing to contribute, but feel free to take a look around if you're interested in how Exercism language tracks are set up.

[web-exercism]: https://exercism.io

## Track Organization

The track is organized with the following main directories and files:

```
bin/               # executables required to manage the track
config/            # configuration files for the track
docs/              # documentation files for automatically generated web pages on exercism.io
.github/workflows/ # CI config for automatic build and tests
exercises/         # contains one directory per exercise
template/          # template used when generating a new exercise
config.json        # main track configuration file for all exercises metadata
package.json       # Node package configuration required for running builds and tests
```

Each exercise within the [`exercises/`](exercises) directory has the following structure:

```
elm.json               # elm json config file for the exercise
src/
  <PascalCaseSlug>.elm # exercise template, where <PascalCaseSlug> is the name of the exercise using PascalCase.
tests/
  Tests.elm            # tests for exercise, imports function(s) from src/<PascalCaseSlug>.elm
.meta/
  Exemplar.elm         # exemplary / example solution for this exercise
  config.json          # name of exercise, prerequisite concepts, concepts taught and similar
  design.md            # describe the learning goals of the exercise
.docs/
   introduction.md     # introduce the concept(s) that the exercise teaches to the student
   instructions.md     # describe the tasks to complete the exercise
   hints.md            # provide hints to a student to help them get themselves unstuck in an exercise
```

## Contributing

We welcome contributions of all sorts and sizes,
from reporting issues to submitting patches or implementing missing exercises.
At the moment we would particularly like some help implementing new concept exercises, and beta testing.

Things are currently in a state of flux with the upcoming v3 release of exercism, so if you would like to help, the best thing at the moment is probably to create an issue in this repository, and then one of us will get in touch with you and discuss what to do.

If you are not familiar with git and GitHub,
you can also have a look at [GitHub's getting started documentation][github-start].

[contributing]: https://github.com/exercism/problem-specifications/blob/master/CONTRIBUTING.md
[github-start]: https://help.github.com/en/github/getting-started-with-github

### Setup

In order to contribute code to this track, you will probably want
[npm][npm-install], [elm][elm-install], [elm-test][elm-test], and [elm-format][elm-format] installed globally.
The build and test script for this track lives at `bin/build.sh`, and uses npx, so can work without the rest of the tools being installed if required.

[npm-install]: https://docs.npmjs.com/downloading-and-installing-node-js-and-npm
[elm-install]: https://guide.elm-lang.org/install/elm.html
[elm-test]: https://www.npmjs.com/package/elm-test
[elm-format]: https://github.com/avh4/elm-format

### Adding Missing Concept Exercise

TODO: link to the step-by-step guide instead here.

Version 3 of Exercism introduced Concepts and Concept Exercises, which are a completely new thing. There is a [dependency diagram](https://mermaid-js.github.io/mermaid-live-editor/#/edit/eyJjb2RlIjoiZ3JhcGggTFJcbiAgQmFzaWNzW01pbmltYWwgY29tcGlsYWJsZSBmaWxlXSAtLT4gSW5kZXBlbmRlbnRzW0ltcG9ydCwgRXhwb3NpbmcsIEZ1bmN0aW9ucywgRmxvYXQsIEludCwgVHlwZSBBbm5vdGF0aW9uc10gLS0-IE1hdGhlbWF0aWNhbC1PcGVyYXRvcnNcbiAgSW5kZXBlbmRlbnRzIC0tPiBNYXRoZW1hdGljYWwtRnVuY3Rpb25zXG4gIEluZGVwZW5kZW50cyAtLT4gTGV0LUV4cHJlc3Npb25zXG4gIEluZGVwZW5kZW50cyAtLT4gRXF1YWxpdHlcbiAgRXF1YWxpdHkgLS0-IE9yZGVyaW5nXG4gIE9yZGVyaW5nIC0tPiBDb21wYXJpc29uc1xuICBJbmRlcGVuZGVudHMgLS0-IFN0cmluZ1xuICBTdHJpbmcgLS0-IFJlZ2V4XG4gIEluZGVwZW5kZW50cyAtLT4gQ2hhclxuICBJbmRlcGVuZGVudHMgLS0-IExpc3RcbiAgTGlzdCAtLT4gTGlzdC1FeHRyYVxuICBJbmRlcGVuZGVudHMgLS0-IERpY3RcbiAgSW5kZXBlbmRlbnRzIC0tPiBTZXRcbiAgSW5kZXBlbmRlbnRzIC0tPiBBcnJheVxuICBJbmRlcGVuZGVudHMgLS0-IFR5cGUtYWxpYXNcbiAgSW5kZXBlbmRlbnRzIC0tPiBTdW0tdHlwZXNcbiAgSW5kZXBlbmRlbnRzIC0tPiBCb29sZWFuc1tCb29sIHR5cGUgLyBvcGVyYXRvcnMsIElmXVxuICBDdXN0b20tdHlwZXNbQ3VzdG9tLXR5cGVzIC8gUGF0dGVybi1tYXRjaGluZ10gLS0-IE1heWJlXG4gIEJvb2xlYW5zIC0tPiBNYXliZVxuICBNYXliZSAtLT4gUmVzdWx0XG4gIEN1c3RvbS10eXBlcyAtLT4gT3BhcXVlLVR5cGVzW09wYXF1ZSBUeXBlcyAvIFBhcnNlIC8gZG9udCB2YWxpZGF0ZV1cbiAgQ3VzdG9tLXR5cGVzIC0tPiBQaGFudG9tLVR5cGVzXG4gIEN1c3RvbS10eXBlcyAtLT4gUGFyc2VyXG4gIEluZGVwZW5kZW50cyAtLT4gRnVuY3Rpb24tY29tcG9zaXRpb25cbiAgSW5kZXBlbmRlbnRzIC0tPiBGdW5jdGlvbi1jaGFpbmluZ1xuICBJbmRlcGVuZGVudHMgLS0-IFBhcnRpYWwtYXBwbGljYXRpb25cbiAgUGFydGlhbC1hcHBsaWNhdGlvbiAtLT4gUG9pbnQtZnJlZXN0eWxlXG4gIEZ1bmN0aW9uLWNvbXBvc2l0aW9uIC0tPiBQb2ludC1mcmVlc3R5bGVcbiAgRnVuY3Rpb24tY2hhaW5pbmcgLS0-IFBvaW50LWZyZWVzdHlsZVxuICBQb2ludC1mcmVlc3R5bGUgLS0-IE9wZXJhdG9yLWZ1bmN0aW9uc1xuICBJbmRlcGVuZGVudHMgLS0-IEJpdHdpc2Utb3BlcmF0b3JzXG4gIEluZGVwZW5kZW50cyAtLT4gQ29udmVyc2lvbnNcbiAgSW5kZXBlbmRlbnRzIC0tPiBQb3NpeC10aW1lIiwibWVybWFpZCI6eyJ0aGVtZSI6ImRlZmF1bHQifSwidXBkYXRlRWRpdG9yIjpmYWxzZX0) showing all the Elm concepts. You can see all concepts currently defined in [`concepts/`](concepts/), and you can se all concept exercises defined in [`/exercises/concept`](/exercises/concept).

We would love some help creating more of these concepts / concept exercises.
To do so, it is probably easiest to copy and paste an existing Concept and Concept Exercise. You will also need to add the meta data for these in [`config.json`][config-json], and again, the easiest way is to copy and edit an existing entry.
The [Concept][concept-documentation] and [Concept Exercise][concept-exercise-documentation] documentation have further details.

[concept-documentation]: https://github.com/exercism/docs/blob/main/building/tracks/concepts.md
[concept-exercise-documentation]: https://github.com/exercism/docs/blob/main/building/tracks/concept-exercises.md

## Elm icon

We were unable to find copyright information about the Elm logo,
nor information about who designed it.
Presumably Evan Czaplicki, creator of the Elm language,
also made the logo, and holds copyright.
It may also fall within the public domain, since it is a geometric shape.
We've adapted the official Elm logo by changing the colors, which we believe falls under "fair use".

[config-json]: config.json
