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


score : Rolls -> Result String Int
score =
    List.foldl (\roll -> Result.andThen (\frames -> update frames roll)) (Ok [])
        >> Result.andThen
            (\frames ->
                case frames of
                    (FinalFrame finalFrame) :: otherFrames ->
                        List.foldl
                            (\frame ->
                                Result.andThen
                                    (\( points, rollPlus1, rollPlus2 ) ->
                                        case frame of
                                            FinalFrame _ ->
                                                Err "only the last frame can be the final one"

                                            Incomplete _ ->
                                                Err "cannot score when a frame is incomplete"

                                            Open rollA rollB ->
                                                Ok ( points + rollA + rollB, rollA, rollB )

                                            Spare secondRoll ->
                                                Ok ( points + 10 + rollPlus1, 10 - secondRoll, secondRoll )

                                            Strike ->
                                                Ok ( points + 10 + rollPlus1 + rollPlus2, 10, rollPlus1 )
                                    )
                            )
                            (case finalFrame of
                                FinalOpen rollA rollB ->
                                    Ok ( rollA + rollB, rollA, rollB )

                                FinalSpare secondRoll (Just fillRoll) ->
                                    Ok ( 10 + fillRoll, 10 - secondRoll, secondRoll )

                                FinalStrike (Just fillRollA) (Just fillRollB) ->
                                    Ok ( 10 + fillRollA + fillRollB, 10, fillRollA )

                                _ ->
                                    Err "cannot score before rolling entirely the final frame"
                            )
                            otherFrames

                    _ ->
                        Err "cannot score incomplete game"
            )
        >> Result.map (\( points, _, _ ) -> points)


update : List Frame -> Int -> Result String (List Frame)
update reversedFrames newRoll =
    if newRoll < 0 then
        Err "cannot make less than 0 point on a roll"

    else if newRoll > 10 then
        Err "cannot score more than 10 points on a roll"

    else if List.length reversedFrames > 10 then
        Err "cannot score more than 10 frames"

    else if List.length reversedFrames == 10 then
        -- dealing with the last frame here
        case reversedFrames of
            (Incomplete firstRoll) :: restOfFrames ->
                let
                    totalFrame =
                        firstRoll + newRoll
                in
                if totalFrame > 10 then
                    Err "cannot score more than 10 points in 2 rolls"

                else if totalFrame == 10 then
                    Ok <| FinalFrame (FinalSpare newRoll Nothing) :: restOfFrames

                else
                    Ok <| FinalFrame (FinalOpen firstRoll newRoll) :: restOfFrames

            (FinalFrame (FinalSpare secondRoll Nothing)) :: restOfFrames ->
                Ok <| FinalFrame (FinalSpare secondRoll (Just newRoll)) :: restOfFrames

            (FinalFrame (FinalStrike Nothing Nothing)) :: restOfFrames ->
                Ok <| FinalFrame (FinalStrike (Just newRoll) Nothing) :: restOfFrames

            (FinalFrame (FinalStrike (Just firstFill) Nothing)) :: restOfFrames ->
                if firstFill /= 10 && firstFill + newRoll > 10 then
                    Err "cannot score more than 10 points without making a strike"

                else
                    Ok <| FinalFrame (FinalStrike (Just firstFill) (Just newRoll)) :: restOfFrames

            _ ->
                Err "trying to cheat by adding rolls are we?"

    else
        case reversedFrames of
            (Incomplete firstRoll) :: restOfFrames ->
                let
                    totalFrame =
                        firstRoll + newRoll
                in
                if totalFrame > 10 then
                    Err "cannot score more than 10 points in 2 rolls"

                else if totalFrame == 10 then
                    Ok <| Spare newRoll :: restOfFrames

                else
                    Ok <| Open firstRoll newRoll :: restOfFrames

            restOfFrames ->
                case ( newRoll == 10, List.length reversedFrames == 9 ) of
                    ( True, False ) ->
                        Ok <| Strike :: restOfFrames

                    ( True, True ) ->
                        Ok <| FinalFrame (FinalStrike Nothing Nothing) :: restOfFrames

                    _ ->
                        Ok <| Incomplete newRoll :: restOfFrames
