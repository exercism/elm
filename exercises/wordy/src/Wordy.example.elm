module Wordy exposing (answer)

import Parser as P exposing ((|.), (|=), Parser, Trailing(..))


{-| An `Operation` is a single mathematical operation. It may contain a nested, preceding operation to the left.
-}
type Operation
    = Display Int
    | Add Number Int
    | Multiply Number Int
    | Divide Number Int


{-| A `Number` may be a literal integer, or the result of a preceding computation.
-}
type Number
    = Number Int
    | Computation Operation


{-| Parses a string and solves any problems correctly specified therein or returns `Nothing` in the event of a parse error.
-}
answer : String -> Maybe Int
answer problem =
    P.run parser problem
        |> Result.toMaybe
        |> Maybe.map solveProblem


{-| Solves an `Operation` (possibly including nested operations) for a numerical result.
-}
solveProblem : Operation -> Int
solveProblem operation =
    let
        toNum num =
            case num of
                Number i ->
                    i

                Computation p ->
                    solveProblem p
    in
    case operation of
        Display i ->
            i

        Add i1 i2 ->
            toNum i1 + i2

        Multiply i1 i2 ->
            toNum i1 * i2

        Divide i1 i2 ->
            toNum i1 // i2


{-| Parses math problems of the form `"What is <x> [chain of operations]?"`, where `<x>` is an integer and `[chain of operations]` is of the form: `"operation1 n1 operation2 n2 operation3 n3"`, where `n`s are integer and `operation`s are selected from the following list:

  - `"plus"` -- Addition
  - `"minus"` -- Subtraction
  - `"multiplied by"` -- Multiplication
  - `"divided by"` -- Division

-}
parser : Parser Operation
parser =
    let
        packOperations : Int -> List (Number -> Operation) -> Operation
        packOperations d l =
            case l of
                [] ->
                    Display d

                f :: fs ->
                    List.foldl (\next prev -> next (Computation prev)) (f (Number d)) fs

        operation : String -> (Number -> Int -> Operation) -> Parser (Number -> Operation)
        operation keyword f =
            P.succeed (\i -> \n -> f n i)
                |. P.keyword keyword
                |= int

        plus =
            operation "plus" Add

        minus =
            operation "minus" (\d1 d2 -> Add d1 (negate d2))

        multiply =
            operation "multiplied by" Multiply

        divide =
            operation "divided by" Divide
    in
    P.succeed packOperations
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
