module Bowling exposing (Rolls, score)


type alias Rolls =
    List Int

{-| There are stronger guarantees we could make with the type system, such as defining a 
Game type that had 9 frames, and then a special case last frame
-}
type Frame
    = Open Int Int
    | Spare Int Int
    | Strike
    | ThreeBallFinalFrame Int Int Int


score : Rolls -> Result String Int
score rolls =
    validateRolls rolls
        |> Result.andThen toFrames
        |> Result.andThen validateFrames
        |> Result.map scoreFrames


validateRolls : Rolls -> Result String Rolls
validateRolls rolls =
    if List.any (\roll -> roll < 0) rolls then
        Err "Negative rolls are invalid"

    else if List.any (\roll -> roll > numberOfPins) rolls then
        Err ("Rolls greater than " ++ String.fromInt numberOfPins ++ " are invalid")

    else
        Ok rolls


validateFrames : List Frame -> Result String (List Frame)
validateFrames frames =
    if List.length frames /= 10 then
        Err "A game must be 10 frames long"

    else
        Ok frames


{-| A solution using Parser is worth thinking about here, and would allow better error messages,
displaying the point where the parsing failed, and the things that had been parsed up to that
point
-}
toFrames : Rolls -> Result String (List Frame)
toFrames rolls =
    case rolls of
        [ a, b, c ] ->
            if isStrike a && not (isStrike b) && b + c > numberOfPins then
                Err "Cannot score more then 10 with last two balls unless the first one is a strike"

            else if a + b >= numberOfPins then
                Ok [ ThreeBallFinalFrame a b c ]

            else
                Err "Can only have 3 rolls in the last frame if a strike or spare is scored with in the first two"

        -- It's a shame we have to hard code 10 here instead of using numberOfPins
        [ 10 ] ->
            Err "If a strike is scored in the first two rolls of the last frame, 3 rolls are required"

        10 :: rest ->
            Result.map ((::) Strike) (toFrames rest)

        a :: b :: rest ->
            if isSpare a b && List.length rest == 0 then
                Err "If a spare is scored in the first two rolls of the last frame, 3 rolls are required"

            else if isSpare a b then
                Result.map ((::) (Spare a b)) (toFrames rest)

            else if a + b > numberOfPins then
                Err ("A frame cannot score more than " ++ String.fromInt numberOfPins)

            else
                Result.map ((::) (Open a b)) (toFrames rest)

        [] ->
            Ok []

        [ _ ] ->
            Err "Invalid single roll"


scoreFrames : List Frame -> Int
scoreFrames frames =
    case frames of
        frame :: rest ->
            case frame of
                Open a b ->
                    a + b + scoreFrames rest

                Spare a b ->
                    a + b + spareBonus rest + scoreFrames rest

                Strike ->
                    numberOfPins + strikeBonus rest + scoreFrames rest

                ThreeBallFinalFrame a b c ->
                    a + b + c

        [] ->
            0


spareBonus : List Frame -> Int
spareBonus frames =
    List.take 1 frames |> framesToRolls |> List.take 1 |> List.sum


strikeBonus : List Frame -> Int
strikeBonus frames =
    List.take 2 frames |> framesToRolls |> List.take 2 |> List.sum


{-| Parsing the individual rolls in to Frame's, and then converting them back again here is
a little counter intuitive, but useful. Another option would be for strikes and spares to
store their subsequent rolls when they are created
-}
framesToRolls : List Frame -> Rolls
framesToRolls frames =
    List.map frameToRolls frames
        |> List.foldr List.append []


frameToRolls : Frame -> Rolls
frameToRolls frame =
    case frame of
        ThreeBallFinalFrame a b c ->
            [ a, b, c ]

        Open a b ->
            [ a, b ]

        Spare a b ->
            [ a, b ]

        Strike ->
            [ numberOfPins ]


isStrike : Int -> Bool
isStrike a =
    a == numberOfPins


isSpare : Int -> Int -> Bool
isSpare a b =
    a + b == numberOfPins


numberOfPins : Int
numberOfPins =
    10
