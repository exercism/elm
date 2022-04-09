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

// Use the canonical data to generate the multiple files
function generateFiles(slug, canonicalData) {
  const exercise = kebabToPascal(slug);

  let extractedFunctions = {};
  extractFunctions(canonicalData, extractedFunctions);

  const functionList = Object.entries(extractedFunctions)
    .map(([key, _]) => key)
    .join(", ");

  const allFunctionsCode = Object.entries(extractedFunctions)
    .map(([key, value]) => generateFunctionCode(key, value))
    .join("\n\n");

  const mainFile = `
module ${exercise} exposing (${functionList})

${allFunctionsCode}
`;
  console.log(mainFile);

  const allTestCode = generateAllTestsCode(
    exercise,
    extractedFunctions,
    canonicalData
  );

  const testFile = `
module Tests exposing (tests)

import ${exercise}
import Expect
import Test exposing (Test, describe, skip, test)

${toElmComments(canonicalData.comments)}

tests : Test
tests = describe "${exercise}" [ ${allTestCode} ]
`;

  console.log(testFile);
}

// Generate the template code for one function
function generateFunctionCode(name, { args, canError }) {
  const returnType = canError ? "Result String Todo" : "Todo";
  const typeAnnotation = [...Array(args.length).fill("Todo"), returnType].join(
    " -> "
  );
  return `
${name} : ${typeAnnotation}
${name} ${args.join(" ")} = Debug.todo "Please implement ${name}"
`;
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
        `
  ${toElmComments(testCase.comments)}

  describe "${testCase.description}" [ ${subtestsOutput} ]
  `
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
      expectedValue = "Err " + jsonValueToElm(expectedValue.error);
    } else {
      expectedValue = "Ok " + jsonValueToElm(expectedValue);
    }
    // Otherwise just convert it into a string
  } else {
    expectedValue = jsonValueToElm(expectedValue);
  }

  // Stringify the test case inputs
  let inputs = "";
  for (const [key, value] of Object.entries(testCase.input)) {
    inputs += " " + jsonValueToElm(value);
  }

  // Generate a re-implement message if this tests re-implements another one
  let reimplements = [];
  if (testCase.reimplements) {
    reimplements = [
      "This test reimplements the test with uuid " + testCase.reimplements,
      "Please identify that test and remove it. Link:",
      "https://github.com/exercism/problem-specifications/blob/main/exercises/" +
        testCase.reimplements +
        "/canonical-data.json",
    ];
  }

  return `
  ${toElmComments(reimplements)}
  ${toElmComments(testCase.comments)}

  -- skip <|
  test "${testCase.description}" <|
    \\() ->
      ${exercise}.${testCase.property} ${inputs}
        |> Expect.equal (${expectedValue})`;
}

// Convert the list of strings composing the comment in the canonical data
// into Elm comments by prepending -- to all lines.
function toElmComments(dataComments) {
  if (dataComments) {
    return dataComments.map((line) => "  -- " + line).join("\n");
  } else {
    return "";
  }
}

// Convert a JSON value into as close as possible Elm code string
function jsonValueToElm(json) {
  switch (typeof json) {
    case "boolean":
      return json ? "True" : "False";
    case "number":
      return JSON.stringify(json);
    case "string":
      return JSON.stringify(json);
    case "object":
      if (json == null) {
        return "Nothing";
      } else if (json.constructor === Array) {
        // Apply a recursive call to all elements of the array
        const arrayContent = json.map(jsonValueToElm).join(", ");
        return `[ ${arrayContent} ]`;
      } else {
        // Apply a recursive call to all attribute values,
        // and lowercase the object keys.
        const toElmKey = (key) =>
          replaceReservedWord(key[0].toLowerCase() + key.slice(1));
        const recordContent = Object.entries(json)
          .map(([key, value]) => toElmKey(key) + " = " + jsonValueToElm(value))
          .join(", ");
        return `{ ${recordContent} }`;
      }
    default:
      return JSON.stringify(json);
  }
}

// Replace words that may be interpreted as Elm keywords.
const reservedWords = new Set([
  "if",
  "then",
  "else",
  "case",
  "of",
  "let",
  "in",
  "type",
  "module",
  "where",
  "import",
  "exposing",
  "as",
  "port",
]);
function replaceReservedWord(word) {
  return reservedWords.has(word) ? word + "Key" : word;
}

// Find all functions in the "property" fields of test cases.
// This also figures out if that function should return a `Result`,
// in case at least one of the test cases returns an `{ error: ... }`.
//
// Update `functions` with function names as keys and `canError` boolean attribute such as:
//
// { f1: { args: [], canError: false }, f2: { args: ["arg1", "arg2"], canError: true } }
function extractFunctions({ cases }, functions) {
  for (const testCase of cases) {
    // This is a group of sub tests.
    if (testCase.cases != null) {
      extractFunctions(testCase, functions);
    }
    // Otherwise we found a test case, update the list of functions.
    else {
      if (!functions.hasOwnProperty(testCase.property)) {
        const fnArgs = Object.entries(testCase.input).map(([argName, _]) =>
          replaceReservedWord(argName[0].toLowerCase() + argName.slice(1))
        );
        functions[testCase.property] = { args: fnArgs, canError: false }; // default value
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
