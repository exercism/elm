#!/usr/bin/env bash

# Exit if anything fails.
set -euo pipefail

# If argument not provided, print usage and exit
if [ -z "$1" ]; then
    echo "Usage: bin/generate.sh <exercise-slug>"
    exit 1
fi

SLUG="$1"
exercise_dir="exercises/practice/${SLUG}"

# build configlet
echo "Fetching latest version of configlet..."
./bin/fetch-configlet

# Preparing config.json
echo "Please adapt and add the following in config.json before continuing: "
UUID=$(bin/configlet uuid)
jq -n --arg slug "$SLUG" --arg uuid "$UUID" \
    '{slug: $slug, name: $slug, uuid: $uuid, practices: [], prerequisites: [], difficulty: 5}'

echo "Press 'y' to continue..."
read -n 1 k <&1
echo ""
if [[ $k != 'y' && $k != 'Y' ]] ; then
    echo "Exiting"
    exit 0
fi

# Create instructions and config files
./bin/configlet sync --update --yes --docs --filepaths --metadata --exercise "$SLUG"
cp template/elm.json $exercise_dir

# Build generator
echo "Building exercise generator..."
cd generate_practice_exercise
elm make --debug src/Main.elm --output=src/main.js
cd ..

# Create Elm files
echo "Creating Elm files..."
mkdir -p ${exercise_dir}/tests ${exercise_dir}/src ${exercise_dir}/.meta/src
curl https://raw.githubusercontent.com/exercism/problem-specifications/main/exercises/${SLUG}/canonical-data.json \
    | node generate_practice_exercise/src/cli.js $SLUG
elm-format --yes ${exercise_dir}/**/*.elm
elm-format --yes ${exercise_dir}/.meta/src/*.elm

echo "All stub files were created. After implementing the solution, tests and configuration, please run:"
echo "    ./bin/configlet sync --update --tests --exercise ${SLUG}"
echo "    ./bin/configlet fmt --update --yes --exercise ${SLUG}"
