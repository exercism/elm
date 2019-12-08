module Wordy exposing (answer)

import Parser as P exposing ((|.), (|=), Parser, Trailing(..))


{-| An `Operation` is a single mathematical operation.
-}
type Operation
    = Add Int
    | Multiply Int
    | Divide Int


{-| Parses a string and solves any problems correctly specified therein or returns `Nothing` in the event of a parse error.
-}
answer : String -> Maybe Int
answer problem =
    P.run parser problem
        |> Result.toMaybe
        |> Maybe.map (List.foldl applyOperation 0)


{-| Given an `Operation` and the previous result, calculates the next result.
-}
applyOperation : Operation -> Int -> Int
applyOperation operation i1 =
    case operation of
        Add i2 ->
            i1 + i2

        Multiply i2 ->
            i1 * i2

        Divide i2 ->
            i1 // i2


{-| Parses math problems of the form `"What is <x> [chain of operations]?"`, where `<x>` is an integer and `[chain of operations]` is of the form: `"operation1 n1 operation2 n2 operation3 n3"`, where `n`s are integer and `operation`s are selected from the following list:

  - `"plus"` -- Addition
  - `"minus"` -- Subtraction
  - `"multiplied by"` -- Multiplication
  - `"divided by"` -- Division

-}
parser : Parser (List Operation)
parser =
    let
        operation : String -> (Int -> Operation) -> Parser Operation
        operation keyword f =
            P.succeed f
                |. P.keyword keyword
                |= int

        plus =
            operation "plus" Add

        minus =
            operation "minus" (Add << negate)

        multiply =
            operation "multiplied by" Multiply

        divide =
            operation "divided by" Divide
    in
    P.succeed ((::) << Add)
        |. P.spaces
        |. P.keyword "What is"
        |= int
        |= P.sequence
            { start = ""
            , separator = ""
            , end = "?"
            , spaces = P.spaces
            , item = P.oneOf [ plus, minus, multiply, divide ]
            , trailing = Optional
            }
        |. P.spaces
        |. P.end


{-| Parses an integer of the form `"117"` or `"-8"`.
-}
int : Parser Int
int =
    P.succeed identity
        |. P.spaces
        |= P.oneOf
            [ P.succeed negate
                |. P.symbol "-"
                |= P.int
            , P.int
            ]
