module Bowling exposing (Rolls, score)


type alias Rolls =
    List Int


type Frame
    = Incomplete Int
    | Open Int Int
    | Spare Int
    | Strike
    | FinalFrame FinalFrame


type FinalFrame
    = FinalOpen Int Int
    | FinalSpare Int (Maybe Int)
    | FinalStrike (Maybe Int) (Maybe Int)


score : Rolls -> Maybe Int
score =
    List.foldl (\roll -> Maybe.andThen (\frames -> update frames roll)) (Just [])
        >> Maybe.andThen
            (\frames ->
                case frames of
                    (FinalFrame finalFrame) :: otherFrames ->
                        List.foldl
                            (\frame ->
                                Maybe.andThen
                                    (\( points, rollPlus1, rollPlus2 ) ->
                                        case frame of
                                            FinalFrame _ ->
                                                -- "only the last frame can be the final one"
                                                Nothing

                                            Incomplete _ ->
                                                -- "cannot score when a frame is incomplete"
                                                Nothing

                                            Open rollA rollB ->
                                                Just ( points + rollA + rollB, rollA, rollB )

                                            Spare secondRoll ->
                                                Just ( points + 10 + rollPlus1, 10 - secondRoll, secondRoll )

                                            Strike ->
                                                Just ( points + 10 + rollPlus1 + rollPlus2, 10, rollPlus1 )
                                    )
                            )
                            (case finalFrame of
                                FinalOpen rollA rollB ->
                                    Just ( rollA + rollB, rollA, rollB )

                                FinalSpare secondRoll (Just fillRoll) ->
                                    Just ( 10 + fillRoll, 10 - secondRoll, secondRoll )

                                FinalStrike (Just fillRollA) (Just fillRollB) ->
                                    Just ( 10 + fillRollA + fillRollB, 10, fillRollA )

                                _ ->
                                    -- "cannot scßore before rolling entirely the final frame"
                                    Nothing
                            )
                            otherFrames

                    _ ->
                        -- "cannot score incomplete game"
                        Nothing
            )
        >> Maybe.map (\( points, _, _ ) -> points)


update : List Frame -> Int -> Maybe (List Frame)
update reversedFrames newRoll =
    if newRoll < 0 then
        -- "cannot make less than 0 point on Maybe. roll"
        Nothing

    else if newRoll > 10 then
        -- "cannot score more than 10 points on a roll"
        Nothing

    else if List.length reversedFrames > 10 then
        -- "cannot score more than 10 frames"
        Nothing

    else if List.length reversedFrames == 10 then
        -- dealing with the last frame here
        case reversedFrames of
            (Incomplete firstRoll) :: restOfFrames ->
                let
                    totalFrame =
                        firstRoll + newRoll
                in
                if totalFrame > 10 then
                    -- "cannot score more than 10 points in 2 rolls"
                    Nothing

                else if totalFrame == 10 then
                    Just <| FinalFrame (FinalSpare newRoll Nothing) :: restOfFrames

                else
                    Just <| FinalFrame (FinalOpen firstRoll newRoll) :: restOfFrames

            (FinalFrame (FinalSpare secondRoll Nothing)) :: restOfFrames ->
                Just <| FinalFrame (FinalSpare secondRoll (Just newRoll)) :: restOfFrames

            (FinalFrame (FinalStrike Nothing Nothing)) :: restOfFrames ->
                Just <| FinalFrame (FinalStrike (Just newRoll) Nothing) :: restOfFrames

            (FinalFrame (FinalStrike (Just firstFill) Nothing)) :: restOfFrames ->
                if firstFill /= 10 && firstFill + newRoll > 10 then
                    -- "cannot score more than 10 points without making a strike"
                    Nothing

                else
                    Just <| FinalFrame (FinalStrike (Just firstFill) (Just newRoll)) :: restOfFrames

            _ ->
                -- "trying to cheat by adding rolls are we?"
                Nothing

    else
        case reversedFrames of
            (Incomplete firstRoll) :: restOfFrames ->
                let
                    totalFrame =
                        firstRoll + newRoll
                in
                if totalFrame > 10 then
                    -- "cannot score more than 10 points in 2 rolls"
                    Nothing

                else if totalFrame == 10 then
                    Just <| Spare newRoll :: restOfFrames

                else
                    Just <| Open firstRoll newRoll :: restOfFrames

            restOfFrames ->
                case ( newRoll == 10, List.length reversedFrames == 9 ) of
                    ( True, False ) ->
                        Just <| Strike :: restOfFrames

                    ( True, True ) ->
                        Just <| FinalFrame (FinalStrike Nothing Nothing) :: restOfFrames

                    _ ->
                        Just <| Incomplete newRoll :: restOfFrames
