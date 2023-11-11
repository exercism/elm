#!/bin/sh

# This script is meant to run in exercism/elm-analyzer, pulled from the exercism/elm CI

set -e # Make script exit when a command fail.
set -u # Exit on usage of undeclared variable.
# set -x # Trace what gets executed.
set -o pipefail # Catch failures in pipes.

# Command line arguments
elm_repo=$1

# Copy repo exercises into temp folder
exercices=$(mktemp -d /tmp/exercices_XXXXXXXXXX)
cp -r "$elm_repo/exercises/concept" "$elm_repo/exercises/practice" $exercices

build="$exercices/build"
rm -rf $build
mkdir -p "$build/src" "$build/tests"
cp "$elm_repo/template/elm.json" "$build/"

# Copying exercises in one directory
for example_file in $exercices/concept/**/.meta/*.elm
do
  exercise_dir=$(dirname $(dirname $example_file))
  # get kebab-case slug and transform it to PascalCase
  exercise_name=$(basename $exercise_dir | sed -r 's/(^|-)([a-z])/\U\2/g')
  cp $exercise_dir/src/*.elm "$build/src/"
  cp $example_file "$build/src/$exercise_name.elm"
  cat "$exercise_dir/tests/Tests.elm" | sed "s/module Tests/module Tests$exercise_name/" | sed 's/skip <|//g' > "$build/tests/Tests$exercise_name.elm"
done

for example_file in $exercices/practice/**/.meta/src/*.example.elm
do
  exercise_dir=$(dirname $(dirname $(dirname $example_file)))
  exercise_name=$(basename $example_file .example.elm)
  cp $example_file "$build/src/$exercise_name.elm"
  cat "$exercise_dir/tests/Tests.elm" | sed "s/module Tests/module Tests$exercise_name/" | sed 's/skip <|//g' > "$build/tests/Tests$exercise_name.elm"
done

echo "Running analyzer"
bin/run.sh "ignored_slug" $build $build > /dev/null
results=$(jq --raw-output '.summary' "$build/analysis.json")
if [[ "$results" != "No suggestions found." ]]; then
  jq '.' "$build/analysis.json"
  exit 1
fi

echo "All exercises analyzed"
