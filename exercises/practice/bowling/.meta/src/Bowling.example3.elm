module Bowling exposing (score)


score : List Int -> Maybe Int
score rolls =
    convertToFrames rolls
        -- Maybe Frames
        |> Maybe.andThen validateFrames
        -- Maybe Frames
        |> Maybe.andThen (\frames -> Just (countPoints frames))


type alias Frames =
    { first9 : List RegularFrame
    , tenth : FinalFrame
    }


type RegularFrame
    = Open { first : Int, second : Int }
    | Spare { first : Int, second : Int }
    | Strike


type FinalFrame
    = TenthOpen { first : Int, second : Int }
    | TenthSpare { first : Int, second : Int, fill : Int }
    | TenthStrike { fill1 : Int, fill2 : Int }


{-| Pack rolls into frames
-}
convertToFrames : List Int -> Maybe Frames
convertToFrames rolls =
    let
        ( maybeRegularFrames, finalRolls ) =
            extractFirst9Frames 0 [] rolls

        maybeFinalFrame =
            extractFinalFrame finalRolls
    in
    Maybe.map2 (\reg final -> Frames reg final) maybeRegularFrames maybeFinalFrame


extractFirst9Frames : Int -> List RegularFrame -> List Int -> ( Maybe (List RegularFrame), List Int )
extractFirst9Frames framesCount alreadyExtracted rolls =
    case ( framesCount, rolls ) of
        ( 9, _ ) ->
            ( Just (List.reverse alreadyExtracted), rolls )

        ( _, 10 :: laterRolls ) ->
            extractFirst9Frames (framesCount + 1) (Strike :: alreadyExtracted) laterRolls

        ( _, r1 :: r2 :: laterRolls ) ->
            if r1 + r2 == 10 then
                extractFirst9Frames (framesCount + 1) (Spare { first = r1, second = r2 } :: alreadyExtracted) laterRolls

            else
                extractFirst9Frames (framesCount + 1) (Open { first = r1, second = r2 } :: alreadyExtracted) laterRolls

        _ ->
            ( Nothing, rolls )


extractFinalFrame : List Int -> Maybe FinalFrame
extractFinalFrame finalRolls =
    case finalRolls of
        10 :: y :: z :: [] ->
            Just (TenthStrike { fill1 = y, fill2 = z })

        x :: y :: z :: [] ->
            Just (TenthSpare { first = x, second = y, fill = z })

        x :: y :: [] ->
            Just (TenthOpen { first = x, second = y })

        _ ->
            Nothing


{-| Validate each frame
-}
validateFrames : Frames -> Maybe Frames
validateFrames ({ first9, tenth } as frames) =
    if validRegularFrames first9 && validFinalFrame tenth then
        Just frames

    else
        Nothing


validRegularFrames : List RegularFrame -> Bool
validRegularFrames frames =
    let
        isValid frame =
            case frame of
                Open { first, second } ->
                    first >= 0 && second >= 0 && first + second < 10

                Spare { first, second } ->
                    first >= 0 && second >= 0 && first + second == 10

                Strike ->
                    True
    in
    List.all isValid frames


validFinalFrame : FinalFrame -> Bool
validFinalFrame frame =
    case frame of
        TenthOpen { first, second } ->
            first >= 0 && second >= 0 && first + second < 10

        TenthSpare { first, second, fill } ->
            first >= 0 && second >= 0 && fill >= 0 && first + second == 10 && fill <= 10

        TenthStrike { fill1, fill2 } ->
            if fill1 == 10 then
                fill2 >= 0 && fill2 <= 10

            else
                fill1 >= 0 && fill2 >= 0 && fill1 + fill2 <= 10


countPoints : Frames -> Int
countPoints { first9, tenth } =
    let
        accumPoints frame ( sum, nextOne, nextTwo ) =
            case frame of
                Open { first, second } ->
                    ( sum + (1 + nextOne + nextTwo) * first + (1 + nextTwo) * second
                    , 0
                    , 0
                    )

                Spare { first, second } ->
                    ( sum + (1 + nextOne + nextTwo) * first + (1 + nextTwo) * second
                    , 1
                    , 0
                    )

                Strike ->
                    ( sum + (1 + nextOne + nextTwo) * 10
                    , nextTwo
                    , 1
                    )

        finalPoints ( sum, nextOne, nextTwo ) finalFrame =
            case finalFrame of
                TenthOpen { first, second } ->
                    sum + (1 + nextOne + nextTwo) * first + (1 + nextTwo) * second

                TenthSpare { first, second, fill } ->
                    sum + (1 + nextOne + nextTwo) * first + (1 + nextTwo) * second + fill

                TenthStrike { fill1, fill2 } ->
                    sum + (1 + nextOne + nextTwo) * 10 + (1 + nextTwo) * fill1 + fill2
    in
    finalPoints (List.foldl accumPoints ( 0, 0, 0 ) first9) tenth
