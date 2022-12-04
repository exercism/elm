module SecureTreasureChest exposing (SecureTreasureChest, createTreasure, getTreasure)


type SecureTreasureChest a
    = SecureTreasureChest String a


createTreasure : String -> a -> Maybe (SecureTreasureChest a)
createTreasure password treasure =
    if String.length password < 8 then
        Nothing

    else
        Just (SecureTreasureChest password treasure)


getTreasure : String -> SecureTreasureChest a -> Maybe a
getTreasure passwordAttempt (SecureTreasureChest password treasure) =
    if passwordAttempt == password then
        Just treasure

    else
        Nothing
