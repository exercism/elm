#!/usr/bin/env bash

# This script is meant to run in the exercism/elm-test-runner, from the exercism/elm CI

set -e # Make script exit when a command fail.
set -u # Exit on usage of undeclared variable.
# set -x # Trace what gets executed.
set -o pipefail # Catch failures in pipes.

# Command line argument
elm_repo_dir=$1

# build docker image
docker build --rm -t elm-test-runner .

# run image passing the arguments
docker run \
    --rm \
    --read-only \
    --network none \
    --mount type=bind,src=$(realpath $elm_repo_dir),dst=/opt/test-runner/elm_repo \
    --mount type=tmpfs,dst=/tmp \
    --volume "$(realpath $elm_repo_dir)/bin/run_all_exercises.sh:/opt/test-runner/bin/run_all_exercises.sh" \
    --entrypoint /opt/test-runner/bin/run_all_exercises.sh \
    elm-test-runner \
    /opt/test-runner/elm_repo
