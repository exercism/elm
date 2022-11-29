#!/bin/sh

set -e # Make script exit when a command fail.
set -u # Exit on usage of undeclared variable.
# set -x # Trace what gets executed.
set -o pipefail # Catch failures in pipes.

# Command line arguments
elm_repo=$1

# Copy repo exercises into temp folder
exercices=$(mktemp -d /tmp/exercices_XXXXXXXXXX)
cp -r "$elm_repo/exercises/concept" "$elm_repo/exercises/practice" $exercices

# Checking assumption that solution files are unique
for config_file in "$exercices"/*/*/.meta/config.json
do
  solution_length=$(jq '.files.solution | length' $config_file)
  if [[ ! $solution_length -eq 1 ]]; then
    echo "$config_file has more than one solution"
    exit 1
  fi
done

# Copy exemplar files in solution
for exercise_dir in "$exercices/concept"/*
do
  solution=$(jq --raw-output '.files.solution | .[0]' "$exercise_dir/.meta/config.json")
  exemplar=$(jq --raw-output '.files.exemplar | .[0]' "$exercise_dir/.meta/config.json")
  cp "$exercise_dir/$exemplar" "$exercise_dir/$solution"
done

# Copy example files in solution
for exercise_dir in "$exercices/practice"/*
do
  solution=$(jq --raw-output '.files.solution | .[0]' "$exercise_dir/.meta/config.json")
  example=$(jq --raw-output '.files.example | .[0]' "$exercise_dir/.meta/config.json")
  cp "$exercise_dir/$example" "$exercise_dir/$solution"
done

# Run tests
for exercise_dir in "$exercices"/*/*
do
  bin/run.sh "ignored_slug" $exercise_dir $exercise_dir > /dev/null
  results=$(jq --raw-output '.status' "$exercise_dir/results.json")
  if [[ $results != "pass" ]]; then
    echo "$exercise_dir is not passing the tests"
    exit 1
  fi
done

echo "All exercises run in the elm-test-runner"
