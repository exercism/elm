const https = require("https");
const fs = require("fs");

// Get slug as argument
const slug = process.argv[2];

// Download the canonical data
let dataUrl = `https://raw.githubusercontent.com/exercism/problem-specifications/main/exercises/${slug}/canonical-data.json`;
https
  .get(dataUrl, (res) => {
    let body = "";
    res.on("data", (chunk) => (body += chunk));
    res.on("end", () => {
      try {
        let canonicalData = JSON.parse(body);
        generateFiles(slug, canonicalData);
      } catch (error) {
        console.error(error.message);
      }
    });
  })
  .on("error", (error) => {
    console.error(error.message);
  });

const mainFileTemplate = `
module <exercise> exposing (<functionList>)

<functions>
`;

// Use the canonical data to generate the multiple files
function generateFiles(slug, canonicalData) {
  let exercise = kebabToPascal(slug);
  console.log(exercise);

  let extractedFunctions = {};
  extractFunctions(canonicalData, extractedFunctions);
  console.log(extractedFunctions);

  let testsCode = generateAllTestsCode(
    exercise,
    extractedFunctions,
    canonicalData
  );
  console.log(testsCode);

  let testFile = `
module Tests exposing (tests)

import ${exercise}
import Expect
import Test exposing (Test, describe, skip, test)

tests : Test
tests = describe "${exercise}" [ ${testsCode} ]
`;

  console.log(testFile);
}

// Generates the test code that should replace `<tests>` in
// `describe "<exercise>" [ <tests> ]`
function generateAllTestsCode(exercise, functions, { cases }) {
  let generatedChunks = [];
  for (const testCase of cases) {
    if (testCase.hasOwnProperty("cases")) {
      // Recursive call with the subgroup
      const subtestsOutput = generateAllTestsCode(
        exercise,
        functions,
        testCase
      );
      generatedChunks.push(
        `describe "${testCase.description}" [ ${subtestsOutput} ]`
      );
    } else {
      generatedChunks.push(generateTestCode(exercise, functions, testCase));
    }
  }
  return generatedChunks.join(", ");
}

// Generate the test code for one test case
function generateTestCode(exercise, functions, testCase) {
  // Extract the expected value
  let expectedValue = testCase.expected;

  // If the function can error, adjust the expected value
  if (functions[testCase.property].canError) {
    if (expectedValue.hasOwnProperty("error")) {
      expectedValue = "Err " + JSON.stringify(expectedValue.error);
    } else {
      expectedValue = "Ok " + JSON.stringify(expectedValue);
    }
    // Otherwise just convert it into a string
  } else {
    expectedValue = JSON.stringify(expectedValue);
  }

  // Stringify the test case inputs
  let inputs = "";
  for (const [key, value] of Object.entries(testCase.input)) {
    inputs += " " + JSON.stringify(value);
  }

  return `
  test "${testCase.description}" <|
    \\() ->
      ${exercise}.${testCase.property} ${inputs}
        |> Expect.equal (${expectedValue})`;
}

// Return a string of the elm record
function jsObjectToElmRecord(obj) {
  // TODO
}

// Find all functions in the "property" fields of test cases.
// This also figures out if that function should return a `Result`,
// in case at least one of the test cases returns an `{ error: ... }`.
//
// Update `functions` with function names as keys and `canError` boolean attribute such as:
//
// { f1: { canError: false }, f2: { canError: true } }
function extractFunctions({ cases }, functions) {
  for (const testCase of cases) {
    // This is a group of sub tests.
    if (testCase.cases != null) {
      extractFunctions(testCase, functions);
    }
    // Otherwise we found a test case, update the list of functions.
    else {
      if (!functions.hasOwnProperty(testCase.property)) {
        functions[testCase.property] = { canError: false }; // default value
      }
      if (testCase.expected.hasOwnProperty("error")) {
        functions[testCase.property].canError = true;
      }
    }
  }
}

// Convert "kebab-case" into "KebabCase"
function kebabToPascal(str) {
  return (
    str
      .split("-")
      // Capitalize each chunk of the slug
      .map((chunk) => chunk.charAt(0).toUpperCase() + chunk.slice(1))
      .join("")
  );
}
