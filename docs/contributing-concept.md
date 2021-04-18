# Contributing a concept + concept exercise

A [concept exercise][product-concept] aims to teach a single concept in a given language.
It should have a clear learning goal and provide enough boilerplate to avoid the student having to learn unnecessary code.
The associated concept has its own documentation, independent of the concept exercise.
Concepts may have other concepts as prerequisites and be locked until the concept exercises of the prerequisites concepts are completed.
Concepts exercises difficulty should not increase as the track progresses.
A concept exercise should be solvable in 5 to 10 minutes by any developper familiar with the prerequisites concepts.

Now that we are familiar with what a concept exercise is, let's detail how to implement one, and it's associated concept.
For reference, the detailed [spec of a concept exercise][concept-exercise-spec] and of a [concept][concept-spec] are available in exercism [docs repository][docs-repo].
This documents gather info from many resources to act as a convenient step-by-step guide on how to contribute a concept exercise.

## 1. Identify a missing concept to implement

Already implemented concepts are located in the `concepts/` directory of this repository.
They are also represented as a dependency graph on [exercism website][concepts-graph-exercism].
You can compare them with the graph of concepts we intend to implement represented below (wait a few seconds and refresh if not visible).

<img height=1080 src="https://markdown-engineering.herokuapp.com/svg/graph LR;  Basics[Minimal compilable file] --> Independents[Import, Exposing, Functions, Float, Int, Type Annotations];  Independents --> Mathematical-Operators;  Independents --> Mathematical-Functions;  Independents --> Let-Expressions;  Independents --> Equality;  Equality --> Ordering;  Ordering --> Comparisons;  Independents --> String;  String --> Regex;  Independents --> Char;  Independents --> List;  List --> List-Extra;  Independents --> Dict;  Independents --> Set;  Independents --> Array;  Independents --> Type-alias;  Independents --> Sum-types;  Independents --> Booleans[Bool type & operators, If];  Sum-types --> Pattern-matching;  Pattern-matching --> Maybe;  Booleans --> Maybe;  Maybe --> Result;  Pattern-matching --> Parser;  Independents --> Function-composition;  Independents --> Function-chaining;  Independents --> Partial-application;  Partial-application --> Point-freestyle;  Function-composition --> Point-freestyle;  Function-chaining --> Point-freestyle;  Point-freestyle --> Operator-functions;  Independents --> Bitwise-operators;  Independents --> Conversions;  Independents --> Posix-time"/>

Identify a missing concept that you want to implement.
Beware that the graph above is a moving target and may change as we find that prerequisites should differ.

## 2. Define the learning goals

It is important to know what a concept exercise aims to teach and what is out of scope so let's create our first file: `exercises/concept/<story-name>/.meta/design.md`.
Since concept exercises are named after the story they use we don't know it yet, so we'll keep `<story-name>` for now and replace it later.
The [`design.md` specification][design-spec] states that this document should define the overall goal of the exercise, its multiple learning objectives, the things that are out of scope, the associated concept it unlocks and the concepts prerequisites to be able to complete the exercise.
You can use the [`design.md` of the boolean concept exercise][design-bool] for a template starting point.


[product-concept]: https://github.com/exercism/docs/blob/main/product/concept-exercises.md
[concept-exercise-spec]: https://github.com/exercism/docs/blob/main/building/tracks/concept-exercises.md
[concept-spec]: https://github.com/exercism/docs/blob/main/building/tracks/concepts.md
[docs-repo]: https://github.com/exercism/docs
[concepts-graph-exercism]: https://exercism.lol/tracks/elm/concepts
[design-spec]: https://github.com/exercism/docs/blob/main/building/tracks/concept-exercises.md#file-metadesignmd
[design-bool]: https://github.com/exercism/elm/blob/contrib-concept/exercises/concept/annalyns-infiltration/.meta/design.md
