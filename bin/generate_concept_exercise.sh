#!/usr/bin/env bash

# Exit if anything fails.
set -euo pipefail

# If argument not provided, print usage and exit
if [[ $# -ne 2 ]]; then
    echo "Usage: bin/generate_concept_exercise.sh <concept-slug> <exercise-slug>"
    exit 1
fi

CONCEPT_SLUG="$1"
EXERCISE_SLUG="$2"
concept_dir="concepts/${CONCEPT_SLUG}"
exercise_dir="exercises/concept/${EXERCISE_SLUG}"

# Build configlet
echo "Fetching latest version of configlet..."
./bin/fetch-configlet

# Prepare config.json
echo "Adding configuration files..."
UUID=$(bin/configlet uuid)
jq --arg slug "$CONCEPT_SLUG" --arg uuid "$UUID" \
    '.concepts += [{uuid: $uuid, slug: $slug, name: "Write name from slug" }]' \
    config.json > config.json.tmp
mv config.json.tmp config.json

UUID=$(bin/configlet uuid)
jq --arg ex_slug "$EXERCISE_SLUG" --arg con_slug "$CONCEPT_SLUG" --arg uuid "$UUID" \
    '.exercises.concept += [{slug: $ex_slug, name: "Write name from slug", uuid: $uuid, concepts: [ $con_slug ], prerequisites: [], status: "beta"}]' \
    config.json > config.json.tmp
mv config.json.tmp config.json

# Create concept files
echo "Creating concept files..."
mkdir -p "${concept_dir}/.meta"
jq -n '{blurb: "Learn how to do X", authors: [], contributors: []}' \
    > ${concept_dir}/.meta/config.json
jq -n '[{url: "https://some.reference/url", description: "Reference description"}]' \
    > ${concept_dir}/links.json
printf "# Introduction\n\nConcept introduction, short version of about.md" \
    > ${concept_dir}/introduction.md
printf "# About\n\nFull concept information" \
    > ${concept_dir}/about.md

# Create concept exercise files
echo "Creating concept exercise files..."
## Elm files
practice_dir="exercises/practice/${EXERCISE_SLUG}"
mkdir -p ${practice_dir}/tests ${practice_dir}/src ${practice_dir}/.meta/src
 jq -n --arg ex_slug "$EXERCISE_SLUG" '{exercise: $ex_slug, cases: [{description: "1", cases: [{description: "First test of Task 1", property: "someFunction", input: {a: 0}, expected: 0}]}, {description: "2", cases: [{description: "First test of Task 2", property: "someOtherFunction", input: {b: 1}, expected: 1}]}]}' \
    | node generate_practice_exercise/src/cli.js $EXERCISE_SLUG
mv $practice_dir $exercise_dir
mv ${exercise_dir}/.meta/src/* ${exercise_dir}/.meta/Exemplar.elm
elm-format --yes ${exercise_dir}/**/*.elm
elm-format --yes ${exercise_dir}/.meta/Exemplar.elm
cp template/elm.json $exercise_dir
rmdir ${exercise_dir}/.meta/src

## .docs
mkdir -p ${exercise_dir}/.docs
printf "# Introduction\n\n%%{concept: $CONCEPT_SLUG}\n" \
    > ${exercise_dir}/.docs/introduction.md.tpl
printf "# Hints\n\n## General\n\n- General hint 1\n\n## 1. Task 1 title\n\n- Task 1 hint\n\n[resource]: https://some.resource/url" \
    > ${exercise_dir}/.docs/hints.md
printf "# Instructions\n\nStory goes here\n\n## 1. Task 1 title\n\nDefine the thing to do the thing" \
    > ${exercise_dir}/.docs/instructions.md

## .meta
SOLUTION=$(ls ${exercise_dir}/src)
jq -n --arg solution "src/${SOLUTION}" \
    '{authors: [], contributors: [], files: {solution: [$solution], test: ["tests/Tests.elm"], exemplar: [".meta/Exemplar.elm"]}, blurb: "Learn this by doing that"}' \
    > ${exercise_dir}/.meta/config.json
printf "# Design\n\n## Goal\n\nThe Goal is to learn X\n\n## Learning objectives\n\n- Know what X is\n\n## Out of scope\n\n- This and that\n\n## Concepts\n\nThe concepts this exercise unlock are:\n\n- booleans\n\n## Prerequisites\n\n- booleans\n\n## Analyzer\n\nMake sure that:\n\n- X is called with Y" \
    > ${exercise_dir}/.meta/design.md

# Done
echo ""
echo "All stub files were created. Once the concept and exercise have been approved, before merging, run the following command to generate the exercise introduction.md:"
echo "    ./bin/configlet generate"

