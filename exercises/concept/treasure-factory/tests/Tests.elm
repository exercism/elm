module Tests exposing (tests)

import Expect
import Test exposing (Test, describe, test)
import TreasureFactory


tests : Test
tests =
    describe "TreasureFactory"
        [ describe "1"
            [ test "module compiles" <|
                \() -> Expect.pass
            , test "makeChest returns a value" <|
                \() ->
                    TreasureFactory.makeChest "password" 1
                        |> Expect.equal (TreasureFactory.makeChest "password" 1)
            , test "makeChest returns a value for different types of treasure" <|
                \() ->
                    TreasureFactory.makeChest "password" "gold"
                        |> Expect.equal (TreasureFactory.makeChest "password" "gold")
            , test "makeChest doesn't internally use a fixed password" <|
                \() ->
                    TreasureFactory.makeChest "password" 1
                        /= TreasureFactory.makeChest "p4$$w0rd" 1
                        |> Expect.true "Chests created with different passwords should not be the same"
            , test "makeChest doesn't internally use a fixed treasure" <|
                \() ->
                    TreasureFactory.makeChest "password" 1
                        /= TreasureFactory.makeChest "password" 2
                        |> Expect.true "Chests created with different treasures should not be the same"
            ]
        , describe "2"
            [ test "chest with passwords of less than 8 characters are insecure" <|
                \() ->
                    TreasureFactory.secureChest (TreasureFactory.makeChest "12345" 1)
                        |> Expect.equal Nothing
            , test "chest with passwords of 8 characters are secure" <|
                \() ->
                    TreasureFactory.secureChest (TreasureFactory.makeChest "12345678" 1)
                        /= Nothing
                        |> Expect.true "Chests with 8 characters should be secure"
            , test "chest with passwords of more than 8 characters are secure" <|
                \() ->
                    TreasureFactory.secureChest (TreasureFactory.makeChest "123456789012345789" 1)
                        /= Nothing
                        |> Expect.true "Chests with more than 8 characters should be secure"
            ]
        , describe "3"
            [ test "chests with identical treasures are never unique" <|
                \() ->
                    [ ( "short", 1 )
                    , ( "small", 1 )
                    , ( "super", 1 )
                    , ( "?", 1 )
                    ]
                        |> List.map (\( password, treasure ) -> TreasureFactory.makeChest password treasure)
                        |> TreasureFactory.uniqueTreasures
                        |> Expect.equal []
            , test "chests with non-unique treasures are removed" <|
                \() ->
                    [ ( "short", 1 )
                    , ( "small", 2 )
                    , ( "super", 2 )
                    , ( "?", 2 )
                    ]
                        |> List.map (\( password, treasure ) -> TreasureFactory.makeChest password treasure)
                        |> TreasureFactory.uniqueTreasures
                        |> List.length
                        |> Expect.equal 1
            , test "chests with different treasures are kept" <|
                \() ->
                    [ ( "password", 1 )
                    , ( "password", 2 )
                    , ( "password", 3 )
                    , ( "password", 4 )
                    ]
                        |> List.map (\( password, treasure ) -> TreasureFactory.makeChest password treasure)
                        |> TreasureFactory.uniqueTreasures
                        |> List.length
                        |> Expect.equal 4
            ]
        , describe "4"
            [ test "treasures have the correct secure passwords" <|
                \() ->
                    [ ( "short", 1 )
                    , ( "small", 2 )
                    , ( "little", 3 )
                    , ( "quite adequate", 4 )
                    , ( "Supercalifragilisticexpialidocious", 5 )
                    ]
                        |> List.map (\( password, treasure ) -> TreasureFactory.makeChest password treasure)
                        |> List.filterMap TreasureFactory.secureChest
                        |> TreasureFactory.uniqueTreasures
                        |> List.map TreasureFactory.makeTreasureChest
                        |> List.map2 TreasureFactory.getTreasure
                            [ "quite adequate", "Supercalifragilisticexpialidocious" ]
                        |> Expect.equalLists [ Just 4, Just 5 ]
            , test "treasures have the correct unique treasures" <|
                \() ->
                    [ ( "not short at all", 1 )
                    , ( "nothing small about this", 2 )
                    , ( "only little in your head", 2 )
                    , ( "quite adequate", 1 )
                    , ( "Supercalifragilisticexpialidocious", 3 )
                    , ( "are we there yet?", 4 )
                    ]
                        |> List.map (\( password, treasure ) -> TreasureFactory.makeChest password treasure)
                        |> List.filterMap TreasureFactory.secureChest
                        |> TreasureFactory.uniqueTreasures
                        |> List.map TreasureFactory.makeTreasureChest
                        |> List.map2 TreasureFactory.getTreasure
                            [ "Supercalifragilisticexpialidocious", "are we there yet?" ]
                        |> Expect.equalLists [ Just 3, Just 4 ]
            , test "number of treasure chests matches number of unique treasures with secure passwords" <|
                \() ->
                    [ ( "not short at all", 1 )
                    , ( "nothing small about this", 2 )
                    , ( "only little in your head", 2 )
                    , ( "quite adequate", 1 )
                    , ( "Supercalifragilisticexpialidocious", 3 )
                    , ( "nope", 4 )
                    ]
                        |> List.map (\( password, treasure ) -> TreasureFactory.makeChest password treasure)
                        |> List.filterMap TreasureFactory.secureChest
                        |> TreasureFactory.uniqueTreasures
                        |> List.map TreasureFactory.makeTreasureChest
                        |> List.map (TreasureFactory.getTreasure "Supercalifragilisticexpialidocious")
                        |> Expect.equal [ Just 3 ]
            , test "unsecure passwords can be removed before considering uniqueness" <|
                \() ->
                    [ ( "short", 1 )
                    , ( "nothing small about this", 2 )
                    , ( "only little in your head", 2 )
                    , ( "quite adequate", 1 )
                    , ( "Supercalifragilisticexpialidocious", 3 )
                    , ( "nope", 4 )
                    ]
                        |> List.map (\( password, treasure ) -> TreasureFactory.makeChest password treasure)
                        |> List.filterMap TreasureFactory.secureChest
                        |> TreasureFactory.uniqueTreasures
                        |> List.map TreasureFactory.makeTreasureChest
                        |> List.map2 TreasureFactory.getTreasure
                            [ "quite adequate", "Supercalifragilisticexpialidocious" ]
                        |> Expect.equalLists [ Just 1, Just 3 ]
            , test "unsecure passwords can be removed after considering uniqueness" <|
                \() ->
                    [ ( "short", 1 )
                    , ( "nothing small about this", 2 )
                    , ( "only little in your head", 2 )
                    , ( "quite adequate", 1 )
                    , ( "Supercalifragilisticexpialidocious", 3 )
                    , ( "nope", 4 )
                    ]
                        |> List.map (\( password, treasure ) -> TreasureFactory.makeChest password treasure)
                        |> TreasureFactory.uniqueTreasures
                        |> List.filterMap TreasureFactory.secureChest
                        |> List.map TreasureFactory.makeTreasureChest
                        |> List.map (TreasureFactory.getTreasure "Supercalifragilisticexpialidocious")
                        |> Expect.equalLists [ Just 3 ]
            ]
        ]
