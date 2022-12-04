module TreasureChest exposing (SecureTreasureChest, createTreasure, getTreasure)


type SecureTreasureChest a
    = SecureTreasureChest String a


createTreasure password treasure =
    if String.length password < 8 then
        Nothing
    else 
        SecureTreasureChest password treasure


getTreasure passwordAttempt secureTreasureChest =
    if passwordAttempt == password then
        Just treasure

    else
        Nothing
