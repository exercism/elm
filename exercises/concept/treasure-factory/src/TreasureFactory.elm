module TreasureFactory exposing (TreasureChest, getTreasure, makeChest, makeTreasureChest, secureChest, uniqueTreasures)


type TreasureChest treasure
    = TreasureChest String treasure


getTreasure : String -> TreasureChest a -> Maybe a
getTreasure passwordAttempt (TreasureChest password treasure) =
    if passwordAttempt == password then
        Just treasure

    else
        Nothing


type Chest todo
    = TODO


makeChest : String -> treasure -> Chest treasure {}
makeChest password treasure =
    Debug.todo "Please implement makeChest"


secureChest : Chest todo -> Maybe (Chest todo)
secureChest chest =
    Debug.todo "Please implement secureChest"


uniqueTreasures : List (Chest todo) -> List (Chest todo)
uniqueTreasures chests =
    Debug.todo "Please implement uniqueTreasures"


makeTreasureChest : Chest treasure { conditions | securePassword : (), uniqueTreasure : () } -> TreasureChest treasure
makeTreasureChest chest =
    Debug.todo "Please implement makeTreasureChest"
