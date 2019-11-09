#!/usr/bin/env bash

set -o errexit  # script exit when a command fails
set -o pipefail # catch errors in pipes
set -o nounset  # exit when your script tries to use undeclared variables

# Retrieve exercise slug
if [ -z $1 ]; then
  echo "No exercise slug provided"
  exit 1
fi
exercise=$1

# Check that the exercise does not already exist
if [ -n "$(find exercises -maxdepth 1 -name ${exercise} -type d)" ]; then
  echo "Exercise '${exercise}' already exists"
  exit 1
fi

# Fetch the problem-specifications repository need by the configlet binary
if [ -z "$(find .. -maxdepth 1 -name "problem-specifications" -type d)" ]; then
  git clone https://github.com/exercism/problem-specifications.git ../problem-specifications
else
  git -C ../problem-specifications pull
fi

# Create exercise directory with generated README.md
if [ -z "$(find bin -name configlet -type f)" ]; then
  bin/fetch-configlet
fi
mkdir -p exercises/${exercise}
bin/configlet generate . --only ${exercise}

# Generate template files for the exercise
cp -r template/* exercises/${exercise}

echo "Done"
echo "---"
echo "Navigate to 'exercises/${exercise}' to start working on '${exercise}'"
