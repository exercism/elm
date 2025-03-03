#!/bin/sh

set -e # Make script exit when a command fail.
set -u # Exit on usage of undeclared variable.
# set -x # Trace what gets executed.
set -o pipefail # Catch failures in pipes.

# Command line arguments
SLUG="$1"
INPUT_DIR="$2"
OUTPUT_DIR="$3"

# Setup a temporary working directory
WORK_DIR=/tmp/solution
mkdir -p $WORK_DIR && rm -rf $WORK_DIR
cp -r $INPUT_DIR $WORK_DIR
# tar xf cache.tar -C $WORK_DIR
cd $WORK_DIR

# Use the cache in .elm/ by redefining the elm home directory.
export ELM_HOME=$WORK_DIR/.elm

# Setup a proxy to fail requests faster in offline mode for the elm compiler.
# Otherwise, the elm compiler freezes for 5s before switching to offline mode.
cat <<EOT >> proxy.conf
LogLevel Error
Port 4343
Listen 127.0.0.1
MaxClients 100
Filter "filter.conf"
FilterDefaultDeny Yes
EOT

touch filter.conf
export https_proxy=127.0.0.1:4343
tinyproxy -d -c proxy.conf &

# Temporarily disable -e mode
set +e
# Un-skip all the skipped tests
sed -i 's/skip <|//g' tests/Tests.elm 2> stderr.txt
STATUS=$?
cat stderr.txt 1>&2
if [ $STATUS -ne 0 ]; then
    jq -n --rawfile m stderr.txt '{version: 3, status: "error", message:$m}' > $OUTPUT_DIR/results.json
    echo "An error occured while un-skipping the tests." 1>&2
    exit 0
fi

# Run the tests
elm-test-rs -v --report exercism --offline > test_results.json 2> stderr.txt
STATUS=$?
cat stderr.txt
# elm-test-rs will exit(0) if tests pass, exit(2) if tests fail
if [ $STATUS -ne 0 ] && [ $STATUS -ne 2 ]; then
    jq -n --rawfile m stderr.txt '{version: 3, status: "error", message:$m}' > $OUTPUT_DIR/results.json
    echo "An error occured while running the tests." 1>&2
    exit 0
fi

# Extract test code
cat tests/Tests.elm | node /opt/test-runner/bin/cli.js > test_code.json 2> stderr.txt
STATUS=$?
cat stderr.txt
if [ $STATUS -ne 0 ]; then
    jq -n --rawfile m stderr.txt '{version: 3, status: "error", message:$m}' > $OUTPUT_DIR/results.json
    echo "An error occurred while extracting the test code snippets." 1>&2
    exit 0
fi

# Check number of tests matches number of extracted code snippets
test_code_length=$(jq 'length' test_code.json)
test_result_length=$(jq '.tests | length' test_results.json)
if [ $test_code_length -ne $test_result_length ] ; then
    err="Number of tests doesn't match number of extracted code snippets. Please report this issue at https://github.com/exercism/elm-test-runner/issues."
    jq -n --arg m "${err}" '{version: 3, status: "error", message:$m}' > $OUTPUT_DIR/results.json
    echo $err 1>&2
    exit 0
fi
set -e

# Merge tests results with extracted test code, in the extracted code order.
jq --slurpfile code test_code.json '.tests = (.tests + ($code | .[0] | to_entries | map({order: .key, name: .value.name, test_code: .value.testCode})) | group_by(.name) | map(add) | sort_by(.order) | map(del(.order)))' test_results.json > $OUTPUT_DIR/results.json

echo Finished
