# Contributing a concept + concept exercise

A [concept exercise][product-concept] aims to teach a single concept in a given language.
It should have a clear learning goal and provide enough boilerplate to avoid the student having to learn unnecessary code.
The associated concept has its own documentation, independent of the concept exercise.
Concepts may have other concepts as prerequisites and be locked until the concept exercises of the prerequisite concepts are completed.
Concept exercise difficulty should not increase as the track progresses.
A concept exercise should be solvable in 5 to 10 minutes by any developper familiar with the prerequisite concepts.

Now that we are familiar with what a concept exercise is, let's detail how to implement one, and it's associated concept.
For reference, the detailed [spec of a concept exercise][concept-exercise-spec] and of a [concept][concept-spec] are available in exercism [docs repository][docs-repo].
This documents gather info from many resources to act as a convenient step-by-step guide on how to contribute a concept exercise.

## 1. Identify a missing concept to implement

Already implemented concepts are located in the [`concepts/`](/concepts) directory of this repository.
They are also represented as a dependency graph on [exercism website][concepts-graph-exercism].
You can compare them with the graph of concepts we intend to implement represented below (wait a few seconds and refresh if not visible).

<img src="https://mermaid.ink/svg/eyJjb2RlIjoiZmxvd2NoYXJ0IFRCO1xuYmFzaWNzLTEgLS0-IGJhc2ljcy0yO1xuYmFzaWNzLTIgLS0-IGJvb2xlYW5zO1xuYmFzaWNzLTIgLS0-IGxpc3RzO1xuYmFzaWNzLTIgLS0-IHJlY29yZHM7XG5iYXNpY3MtMiAtLT4gY3VzdG9tLXR5cGVzO1xubGlzdHMgLS0-IHR1cGxlcztcbnJlY29yZHMgLS0-IG1heWJlO1xuXG5iYXNpY3MtMiAtLT4gbGV0O1xuXG5saXN0cyAtLT4gZ2VuZXJpY3M7XG5yZWNvcmRzIC0tPiBnZW5lcmljcztcbm1heWJlIC0tPiBnZW5lcmljcztcblxudHVwbGVzIC0tPiBjb21wYXJpc29uO1xubGlzdHMgLS0-IGNvbXBhcmlzb247XG5cbmNvbXBhcmlzb24gLS0-IHNldDtcblxuY29tcGFyaXNvbiAtLT4gZGljdDtcbm1heWJlIC0tPiBkaWN0O1xuXG5saXN0cyAtLT4gYXJyYXk7XG5tYXliZSAtLT4gYXJyYXk7XG5cbm1heWJlIC0tPiByZXN1bHQ7XG5jdXN0b20tdHlwZXMgLS0-IHJlc3VsdDtcblxuYmFzaWNzLTIgLS0-IHBhcnRpYWwtYXBwbGljYXRpb247XG5cbnBhcnRpYWwtYXBwbGljYXRpb24gLS0-IGNvbXBvc2l0aW9uO1xuXG5jbGFzc0RlZiBkb25lIGZpbGw6IzZmNixzdHJva2U6IzMzMyxzdHJva2Utd2lkdGg6M3B4O1xuY2xhc3MgYmFzaWNzLTEsYmFzaWNzLTIsYm9vbGVhbnMsbGlzdHMscmVjb3JkcyxjdXN0b20tdHlwZXMsdHVwbGVzLG1heWJlIGRvbmU7XG4iLCJtZXJtYWlkIjp7InRoZW1lIjoiZGVmYXVsdCJ9LCJ1cGRhdGVFZGl0b3IiOmZhbHNlLCJhdXRvU3luYyI6dHJ1ZSwidXBkYXRlRGlhZ3JhbSI6ZmFsc2V9"/>

Already implemented concepts should appear with a green background and a stronger outline.
Beware that the above graph is a moving target and may change as we find that prerequisites should differ.

Concepts and concept exercises that have not been implemented yet should also be listed in the GitHub issues of this repo, with the label [`x:module/concept-exercise`](https://github.com/exercism/elm/issues?q=is%3Aissue+is%3Aopen+label%3Ax%3Amodule%2Fconcept-exercise).

## 2. Define the learning goals

It is important to know what a concept exercise aims to teach and what is out of scope so let's create our first file: `exercises/concept/<story-name>/.meta/design.md`.
Since concept exercises are named after the story they use we don't know it yet, so we'll keep `story-name` for now and replace it later.
The [`design.md` specification][design-spec] states that this document should define the overall goal of the exercise, its multiple learning objectives, the things that are out of scope, the associated concept it unlocks and the concept prerequisites to be able to complete the exercise.
You can use the [`design.md` of the boolean concept exercise][design-bool] as a template starting point.

## 3. Write a concept introduction for the exercise

Once the learning objectives are clear, it's time to write an introduction explaining enough of the concept for a student to then solve the exercise.
Create a file `exercises/concept/<story-name>/.docs/introduction.md`.
The detailed contents of this file are explained in [its specification][exercise-intro-spec].
You can use the [`introduction.md` of the boolean concept exercise][intro-bool] as a template starting point.

The information provided should introduce the concept just enough for the student to figure out the exercise solution themselves.
Use proper technical terms to ease student online search.
Try to avoid links and instead explain things concisely inline.
Introduce code syntax with code blocks.

## 4. Find a story for the exercise

Each concept exercise must be based on a story or a theme.
We try to make them as inclusive as possible, knowing that Exercism is used worldwide.
The first option is to reuse an existing story within the [list of stories recorded in the docs][stories].
If you want to create a new story, don't hesitate to ping @exercism/leadership in your PR.
You can now rename the `exercises/concept/<story-name>/` directory to match your story.

## 5. Write the exercise instructions

Once the story is found, we have to write precise instructions enumerating the tasks a student will have to perform.
Both the story and the instructions are written in the `exercises/concept/<story-name>/.docs/instructions.md` document.
As explained in [that document specification][instructions-spec], each task has its own level-2 markdown title (`## 1. Do X`) followed by a description and an example code usage.
You can use the [`instructions.md` of the boolean concept exercise][instructions-bool] as a template starting point.

In addition to `instructions.md`, we also need a `hints.md` file.
It should contain the same level-2 titles (`## 1. Do X`) as the instructions file so that the right hints are given depending on the current task being worked on.
There can also be a `## General` section for hints applying to all tasks.
Hints should not spell out the solution directly.
Also, beware that people clicking on hints might already be confused/overwhelmed/frustrated by the exercise.
More info on this document is available in [its spec][hints-spec] and you can use the [`hints.md` of the boolean concept exercise][hints-bool] as a template starting point.

## 6. Open a draft a pull request to validate the design

Now is a good time to open a draft pull request for your concept exercise!
We have enough material to evaluate the exercise and reshape it if necessary before commiting to its current state for the rest of the required files.
Don't worry if the automatic checks in the CI fail because of missing documents, we will create them later!

## 7. Write the code

We will be writing the code as if we were solving the exercise, and later we will move files around to adhere to the specs.
Let's start by copying the contents of the [`template/`][template] directory inside our `exercises/concept/<story-name>/` directory.
It means we have the following files:

```txt
elm.json           # elm project configuration file
src/Exercise.elm   # code for the exercise
tests/Tests.elm    # tests for the exercise
```

Then rename `Exercise.elm` to use the PascalCase of the story name.
For example, `annalyns-infiltration` becomes `AnnalynsInfiltration.elm`.
Inside that source file, you can now write all the functions described in the `instructions.md` we just wrote.

Once the exercise is implemented, update the `tests/Tests.elm` file contents to include relevant tests that naturally follow the order of the tasks in `instructions.md`.
**Please refrain from using `Fuzz`** in the tests of concept exercises since it does not play well with the ability to debug the code with `Debug.log`.
Instead, include a few corner cases and general cases unit tests.
**Please refrain from using `let` expressions directly under `test` or `describe` function calls** in the tests of concept exercises since the [elm test runner does not yet support this](https://github.com/exercism/elm-test-runner/issues/30).

Once both the exercise and the tests are done and working well, do the following things:

- Copy `src/<ExerciseSlug>.elm` to `.meta/Exemplar.elm`. Your implementation serves as a reference, an "exemplar" implementation for the exercise, which is used when running the track tests.
- Remove all the implementations inside `src/<ExerciseSlug>.elm` to be left with a starter file ready for the student to start the exercise.

## 8. Write the concept documentation

Create a `concepts/<concept>/` directory for the concept associated with our `exercises/concept/<story-name>` exercise.
Inside that new folder, we create two markdown documents [`introduction.md`][concept-intro-spec] and [`about.md`][concept-about-spec] and one [`links.json`][concept-links-spec] file (links lead to their spec).

The `introduction.md` concept file contains the presentation that students will see on the concept page as long as they haven't completed the associated concept exercise.
It should give them a good overview of what they will learn if the start the associated exercise.
In contrast, the `about.md` concept file contains the concept summary that a student will see on the concept page only after they have completed the associated concept exercise.
As such those are similar in contents than the `exercises/concept/<story-name>/.docs/introduction.md` file we have already written but not the same.
I suggest to start from the exercise intro document and to simplify it to its essence for the concept file `introduction.md`.
And for the `about.md` document, start with the exercise intro and complete it such that all relevant information regarding the concept are present in that page.
`links.json` provides helpful links with additional information about a concept.
These might be official docs, a great tutorial, etc.
These links do not replace the more contextual links within a concept's about.md file, but provide a quick set of overarching reference points for a student.
Links can also optionally have an icon_url field, which can be used to customize the icon shown when the link is displayed. If not specified, the icon defaults to the favicon.
You can find available icons at [github.com/exercism/website-icons/tree/main/exercises][icons].

## 9. Complete the different config files

Now that the code and documentation are done, we are left with the few config files to make this PR complete:

- [`concepts/<concept>/.meta/config.json`][concept-config-json]: make yourself an author, potential reviewers contributors and add a "blurb" (short description).
- [`exercises/concept/<story-name>/.meta/config.json`][exercise-config-json]: contains authors (you), contributors, blurb and other stuff. Refer to the linked spec.
- `config.json`: add a [concept entry][track-config-json-concept] and a [concept exercise entry][track-config-json-concept-exercise] in the track `config.json` file. Use "wip" or "beta" for the status key of the concept exercise. The UUIDs can be generated thanks to the [configlet executable][configlet] provided by exercism.

## 10. THANK YOU!

Thank you for your contribution to exercism, you are awesome!

[product-concept]: https://github.com/exercism/docs/blob/main/building/product/concept-exercises.md
[concept-exercise-spec]: https://github.com/exercism/docs/blob/main/building/tracks/concept-exercises.md
[concept-spec]: https://github.com/exercism/docs/blob/main/building/tracks/concepts.md
[docs-repo]: https://github.com/exercism/docs
[concepts-graph-exercism]: https://exercism.org/tracks/elm/concepts
[design-spec]: https://github.com/exercism/docs/blob/main/building/tracks/concept-exercises.md#file-metadesignmd
[design-bool]: https://github.com/exercism/elm/blob/main/exercises/concept/annalyns-infiltration/.meta/design.md
[exercise-intro-spec]: https://github.com/exercism/docs/blob/main/building/tracks/concept-exercises.md#file-docsintroductionmd
[intro-bool]: https://github.com/exercism/elm/blob/main/exercises/concept/annalyns-infiltration/.docs/introduction.md
[stories]: https://github.com/exercism/docs/tree/main/building/tracks/stories
[instructions-spec]: https://github.com/exercism/docs/blob/main/building/tracks/concept-exercises.md#file-docsinstructionsmd
[instructions-bool]: https://github.com/exercism/elm/blob/main/exercises/concept/annalyns-infiltration/.docs/instructions.md
[hints-spec]: https://github.com/exercism/docs/blob/main/building/tracks/concept-exercises.md#file-docshintsmd
[hints-bool]: https://github.com/exercism/elm/blob/main/exercises/concept/annalyns-infiltration/.docs/hints.md
[template]: https://github.com/exercism/elm/tree/main/template
[concept-intro-spec]: https://github.com/exercism/docs/blob/main/building/tracks/concepts.md#file-introductionmd
[concept-about-spec]: https://github.com/exercism/docs/blob/main/building/tracks/concepts.md#file-aboutmd
[concept-links-spec]: https://github.com/exercism/docs/blob/main/building/tracks/concepts.md#file-linksjson
[icons]: https://github.com/exercism/website-icons/tree/main/exercises
[concept-config-json]: https://github.com/exercism/docs/blob/main/building/tracks/concepts.md#file-metaconfigjson
[exercise-config-json]: https://github.com/exercism/docs/blob/main/building/tracks/concept-exercises.md#file-metaconfigjson
[track-config-json-concept]: https://github.com/exercism/docs/blob/main/building/tracks/config-json.md#concepts
[track-config-json-concept-exercise]: https://github.com/exercism/docs/blob/main/building/tracks/config-json.md#concept-exercises
[configlet]: https://github.com/exercism/configlet
