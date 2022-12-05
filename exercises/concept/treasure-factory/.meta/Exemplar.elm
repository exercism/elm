module TreasureFactory exposing (TreasureChest, getTreasure, makeChest, makeTreasureChest, secureChest, uniqueTreasures)


type TreasureChest treasure
    = TreasureChest String treasure


getTreasure : String -> TreasureChest a -> Maybe a
getTreasure passwordAttempt (TreasureChest password treasure) =
    if passwordAttempt == password then
        Just treasure

    else
        Nothing


type Chest treasure conditions
    = Chest String treasure


makeChest : String -> treasure -> Chest treasure {}
makeChest password treasure =
    Chest password treasure


secureChest : Chest treasure conditions -> Maybe (Chest treasure { conditions | securePassword : () })
secureChest (Chest password treasure) =
    if String.length password >= 12 then
        Just (Chest password treasure)

    else
        Nothing


uniqueTreasures : List (Chest treasure conditions) -> List (Chest treasure { conditions | uniqueTreasure : () })
uniqueTreasures chests =
    let
        extractTreasure (Chest _ treasure) =
            treasure

        treasures =
            List.map extractTreasure chests

        toUnique : Chest treasure conditions -> Maybe (Chest treasure { conditions | uniqueTreasure : () })
        toUnique (Chest password treasure) =
            if unique treasure treasures then
                Just (Chest password treasure)

            else
                Nothing
    in
    List.filterMap toUnique chests


unique : a -> List a -> Bool
unique element list =
    list
        |> List.filter (\el -> el == element)
        |> List.length
        |> (==) 1


makeTreasureChest : Chest treasure { conditions | securePassword : (), uniqueTreasure : () } -> TreasureChest treasure
makeTreasureChest (Chest password treasure) =
    TreasureChest password treasure
