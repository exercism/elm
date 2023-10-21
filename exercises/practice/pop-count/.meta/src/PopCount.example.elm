module PopCount exposing (eggCount)


eggCount : Int -> Int
eggCount n =
    doEggCount n 0


doEggCount : Int -> Int -> Int
doEggCount value eggs =
    if value == 0 then
        eggs

    else if modBy 2 value == 0 then
        doEggCount (value // 2) eggs

    else
        doEggCount (value // 2) (eggs + 1)
