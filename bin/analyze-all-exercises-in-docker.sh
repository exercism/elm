#!/usr/bin/env bash

set -e # Make script exit when a command fail.
set -u # Exit on usage of undeclared variable.
# set -x # Trace what gets executed.
set -o pipefail # Catch failures in pipes.

# pull docker image
docker pull exercism/elm-analyzer

# run image passing the arguments
docker run \
    --rm \
    --read-only \
    --network none \
    --mount type=bind,src=${PWD},dst=/opt/analyzer/elm_repo \
    --mount type=tmpfs,dst=/tmp \
    --volume "${PWD}/bin/analyze_all_exercises.sh:/opt/analyzer/bin/analyze_all_exercises.sh" \
    --entrypoint /opt/analyzer/bin/analyze_all_exercises.sh \
    exercism/elm-analyzer \
    /opt/analyzer/elm_repo
