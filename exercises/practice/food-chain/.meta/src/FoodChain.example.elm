module FoodChain exposing (recite)


recite : Int -> Int -> String
recite startVerse endVerse =
    List.range startVerse endVerse
        |> List.map (verseLines >> String.join "\n")
        |> String.join "\n\n"


songData : List ( String, String )
songData =
    [ ( "horse", "She's dead, of course!" )
    , ( "cow", "I don't know how she swallowed a cow!" )
    , ( "goat", "Just opened her throat and swallowed a goat!" )
    , ( "dog", "What a hog, to swallow a dog!" )
    , ( "cat", "Imagine that, to swallow a cat!" )
    , ( "bird", "How absurd to swallow a bird!" )
    , ( "spider", "It wriggled and jiggled and tickled inside her." )
    , ( "fly", "I don't know why she swallowed the fly. Perhaps she'll die." )
    ]


numberOfVerses : Int
numberOfVerses =
    8


verseLines : Int -> List String
verseLines n =
    let
        line animal =
            "I know an old lady who swallowed a " ++ animal ++ "."
    in
    case List.drop (numberOfVerses - n) songData of
        [] ->
            []

        ( "horse" as animal, phrase ) :: _ ->
            [ line animal, phrase ]

        ( animal, phrase ) :: rest ->
            line animal :: phrase :: escalation animal rest


escalation : String -> List ( String, String ) -> List String
escalation animal remainingData =
    let
        line nextAnimal =
            "She swallowed the " ++ animal ++ " to catch the " ++ nextAnimal ++ "."
    in
    case remainingData of
        [] ->
            []

        [ ( lastAnimal, lastPhrase ) ] ->
            [ line lastAnimal, lastPhrase ]

        ( "spider" as nextAnimal, _ ) :: rest ->
            line "spider that wriggled and jiggled and tickled inside her" :: escalation nextAnimal rest

        ( nextAnimal, _ ) :: rest ->
            line nextAnimal :: escalation nextAnimal rest
