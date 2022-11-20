module ZebraPuzzle exposing (Nationality(..), drinksWater, ownsZebra)


type Number
    = One
    | Two
    | Three
    | Four
    | Five


type Nationality
    = Japanese
    | Norwegian
    | English
    | Spanish
    | Ukrainian


type Color
    = Red
    | Green
    | Blue
    | Yellow
    | Ivory


type Drink
    = Tea
    | Milk
    | OrangeJuice
    | Coffee
    | Water


type Animal
    = Zebra
    | Dog
    | Snails
    | Horse
    | Fox


type CigaretteBrand
    = Chesterfields
    | OldGold
    | Kools
    | LuckyStrike
    | Parliaments


type alias House =
    { number : Number
    , nationality : Nationality
    , color : Color
    , drink : Drink
    , animal : Animal
    , cigaretteBrand : CigaretteBrand
    }


drinksWater : Maybe Nationality
drinksWater =
    solution
        |> List.filter (\house -> .drink house == Water)
        |> List.map .nationality
        |> List.head


ownsZebra : Maybe Nationality
ownsZebra =
    solution
        |> List.filter (\house -> .animal house == Zebra)
        |> List.map .nationality
        |> List.head


solution : List House
solution =
    let
        reducedPossibilities =
            allPossibilities |> applySameHouseConstraints sameHouseConstraints |> applyneighboringHouseConstraint

        iterate possibilities =
            let
                newPossibilities =
                    possibilities |> applySameHouseConstraints (findNewSameHouseConstraints possibilities) |> applyneighboringHouseConstraint
            in
            if List.length newPossibilities == List.length possibilities then
                possibilities

            else
                iterate newPossibilities
    in
    iterate reducedPossibilities


allPossibilities : List House
allPossibilities =
    List.concatMap
        (\number ->
            List.concatMap
                (\nationality ->
                    List.concatMap
                        (\color ->
                            List.concatMap
                                (\drink ->
                                    List.concatMap
                                        (\animal ->
                                            List.map (House number nationality color drink animal)
                                                [ Chesterfields, OldGold, Kools, LuckyStrike, Parliaments ]
                                        )
                                        [ Zebra, Dog, Snails, Horse, Fox ]
                                )
                                [ Tea, Milk, OrangeJuice, Coffee, Water ]
                        )
                        [ Red, Green, Blue, Yellow, Ivory ]
                )
                [ Japanese, Norwegian, English, Spanish, Ukrainian ]
        )
        [ One, Two, Three, Four, Five ]


sameHouseConstraints : List (House -> Bool)
sameHouseConstraints =
    [ -- 2. The Englishman lives in the red house.
      sameHouseConstraint .nationality English .color Red

    -- 3. The Spaniard owns the dog.
    , sameHouseConstraint .nationality Spanish .animal Dog

    -- 4. Coffee is drunk in the green house.
    , sameHouseConstraint .drink Coffee .color Green

    -- 5. The Ukrainian drinks tea.
    , sameHouseConstraint .nationality Ukrainian .drink Tea

    -- 7. The Old Gold smoker owns snails.
    , sameHouseConstraint .cigaretteBrand OldGold .animal Snails

    -- 8. Kools are smoked in the yellow house.
    , sameHouseConstraint .cigaretteBrand Kools .color Yellow

    -- 9. Milk is drunk in the middle house.
    , sameHouseConstraint .drink Milk .number Three

    -- 10. The Norwegian lives in the first house.
    , sameHouseConstraint .nationality Norwegian .number One

    -- 13. The Lucky Strike smoker drinks orange juice.
    , sameHouseConstraint .cigaretteBrand LuckyStrike .drink OrangeJuice

    -- 14. The Japanese smokes Parliaments.
    , sameHouseConstraint .nationality Japanese .cigaretteBrand Parliaments
    ]


sameHouseConstraint : (House -> a) -> a -> (House -> b) -> b -> House -> Bool
sameHouseConstraint field1 val1 field2 val2 house =
    case ( field1 house == val1 && field2 house == val2, field1 house == val1, field2 house == val2 ) of
        ( True, _, _ ) ->
            True

        ( _, True, _ ) ->
            False

        ( _, _, True ) ->
            False

        _ ->
            True


applySameHouseConstraints : List (House -> Bool) -> List House -> List House
applySameHouseConstraints constraints =
    List.filter (\house -> List.all (\constraint -> constraint house) constraints)


neighboringHouseConstraints : List (List House -> House -> Bool)
neighboringHouseConstraints =
    [ -- 6. The green house is immediately to the right of the ivory house.
      neighboringHouseConstraint rightNeighbor .color Ivory .color Green
    , neighboringHouseConstraint leftNeighbor .color Green .color Ivory

    -- 11. The man who smokes Chesterfields lives in the house next to the man with the fox.
    , neighboringHouseConstraint neighbors .cigaretteBrand Chesterfields .animal Fox
    , neighboringHouseConstraint neighbors .animal Fox .cigaretteBrand Chesterfields

    -- 12. Kools are smoked in the house next to the house where the horse is kept.
    , neighboringHouseConstraint neighbors .cigaretteBrand Kools .animal Horse
    , neighboringHouseConstraint neighbors .animal Horse .cigaretteBrand Kools

    -- 15. The Norwegian lives next to the blue house.
    , neighboringHouseConstraint neighbors .nationality Norwegian .color Blue
    , neighboringHouseConstraint neighbors .color Blue .nationality Norwegian
    ]


neighbors : Number -> List Number
neighbors number =
    case number of
        One ->
            [ Two ]

        Two ->
            [ One, Three ]

        Three ->
            [ Two, Four ]

        Four ->
            [ Three, Five ]

        Five ->
            [ Four ]


rightNeighbor : Number -> List Number
rightNeighbor number =
    case number of
        One ->
            [ Two ]

        Two ->
            [ Three ]

        Three ->
            [ Four ]

        Four ->
            [ Five ]

        Five ->
            []


leftNeighbor : Number -> List Number
leftNeighbor number =
    case number of
        One ->
            []

        Two ->
            [ One ]

        Three ->
            [ Two ]

        Four ->
            [ Three ]

        Five ->
            [ Four ]


neighboringHouseConstraint : (Number -> List Number) -> (House -> a) -> a -> (House -> b) -> b -> List House -> House -> Bool
neighboringHouseConstraint getNeighbors field1 val1 field2 val2 houses house =
    let
        numbersOfHousesWithField1 =
            List.filter (\h -> field1 h == val1) houses
                |> List.map .number
                |> List.concatMap getNeighbors
    in
    field2 house /= val2 || List.member (.number house) numbersOfHousesWithField1


applyneighboringHouseConstraint : List House -> List House
applyneighboringHouseConstraint houses =
    List.filter (\house -> List.all (\constraint -> constraint houses house) neighboringHouseConstraints) houses


findNewSameHouseConstraints : List House -> List (House -> Bool)
findNewSameHouseConstraints houses =
    List.concatMap
        (\house ->
            List.filterMap identity
                [ newConstraint .nationality house houses
                , newConstraint .color house houses
                , newConstraint .drink house houses
                , newConstraint .animal house houses
                , newConstraint .cigaretteBrand house houses
                ]
        )
        houses


newConstraint : (House -> a) -> House -> List House -> Maybe (House -> Bool)
newConstraint field house houses =
    let
        typesOfFieldInHouse =
            List.filterMap
                (\h ->
                    if .number h == .number house then
                        Just (field h)

                    else
                        Nothing
                )
                houses

        houseOnlyHasOneTypeOfField =
            List.length (unique typesOfFieldInHouse) == 1

        typeOfFieldIsOnlyFoundInHouse =
            List.all (\h -> field h /= field house || .number h == .number house) houses
    in
    if houseOnlyHasOneTypeOfField || typeOfFieldIsOnlyFoundInHouse then
        Just (sameHouseConstraint field (field house) .number (.number house))

    else
        Nothing


unique : List a -> List a
unique list =
    case list of
        [] ->
            []

        head :: tail ->
            head :: unique (List.filter (\x -> x /= head) tail)
