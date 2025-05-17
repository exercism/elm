module BirdCount exposing (busyDays, hasDayWithoutBirds, incrementDayCount, today, total)


today : List Int -> Maybe Int
today counts =
    case counts of
        [] ->
            Nothing

        head :: _ ->
            Just head


incrementDayCount : List Int -> List Int
incrementDayCount counts =
    case counts of
        [] ->
            [ 1 ]

        head :: tail ->
            (head + 1) :: tail


hasDayWithoutBirds : List Int -> Bool
hasDayWithoutBirds counts =
    case counts of
        [] ->
            False

        0 :: _ ->
            True

        _ :: tail ->
            hasDayWithoutBirds tail


total : List Int -> Int
total counts =
    case counts of
        [] ->
            0

        head :: tail ->
            head + total tail


busyDays : List Int -> Int
busyDays counts =
    case counts of
        [] ->
            0

        head :: tail ->
            if head >= 5 then
                1 + busyDays tail

            else
                busyDays tail
