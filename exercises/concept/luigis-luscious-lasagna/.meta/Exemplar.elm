module LuigisLusciousLasagna exposing (remainingTimeInMinutes)


remainingTimeInMinutes : Int -> Int -> Int
remainingTimeInMinutes layers minutesSinceStarting =
    let
        expectedMinutesInOven =
            40

        preparationTimeInMinutes layers =
            2 * layers
    in
    preparationTimeInMinutes + expectedMinutesInOven - minutesSinceStarting
