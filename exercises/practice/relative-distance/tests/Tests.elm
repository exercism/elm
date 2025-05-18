module Tests exposing (tests)

import Dict exposing (Dict)
import Expect
import RelativeDistance
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "RelativeDistance"
        [ test "Direct parent-child relation" <|
            \() ->
                RelativeDistance.degreeOfSeparation
                    (Dict.fromList
                        [ ( "Vera", [ "Tomoko" ] )
                        , ( "Tomoko", [ "Aditi" ] )
                        ]
                    )
                    "Vera"
                    "Tomoko"
                    |> Expect.equal 1
        , skip <|
            test "Sibling relationship" <|
                \() ->
                    RelativeDistance.degreeOfSeparation
                        (Dict.fromList
                            [ ( "Dalia", [ "Olga", "Yassin" ] ) ]
                        )
                        "Olga"
                        "Yassin"
                        |> Expect.equal 1
        , skip <|
            test "Two degrees of separation, grandchild" <|
                \() ->
                    RelativeDistance.degreeOfSeparation
                        (Dict.fromList
                            [ ( "Khadija", [ "Mateo" ] )
                            , ( "Mateo", [ "Rami" ] )
                            ]
                        )
                        "Khadija"
                        "Rami"
                        |> Expect.equal 2
        , skip <|
            test "Unrelated individuals" <|
                \() ->
                    RelativeDistance.degreeOfSeparation
                        (Dict.fromList
                            [ ( "Priya", [ "Rami" ] )
                            , ( "Kaito", [ "Elif" ] )
                            ]
                        )
                        "Priya"
                        "Kaito"
                        |> Expect.equal -1
        , skip <|
            test "Complex graph, cousins" <|
                \() ->
                    RelativeDistance.degreeOfSeparation
                        (Dict.fromList
                            [ ( "Aiko", [ "Bao", "Carlos" ] )
                            , ( "Bao", [ "Dalia", "Elias" ] )
                            , ( "Carlos", [ "Fatima", "Gustavo" ] )
                            , ( "Dalia", [ "Hassan", "Isla" ] )
                            , ( "Elias", [ "Javier" ] )
                            , ( "Fatima", [ "Khadija", "Liam" ] )
                            , ( "Gustavo", [ "Mina" ] )
                            , ( "Hassan", [ "Noah", "Olga" ] )
                            , ( "Isla", [ "Pedro" ] )
                            , ( "Javier", [ "Quynh", "Ravi" ] )
                            , ( "Khadija", [ "Sofia" ] )
                            , ( "Liam", [ "Tariq", "Uma" ] )
                            , ( "Mina", [ "Viktor", "Wang" ] )
                            , ( "Noah", [ "Xiomara" ] )
                            , ( "Olga", [ "Yuki" ] )
                            , ( "Pedro", [ "Zane", "Aditi" ] )
                            , ( "Quynh", [ "Boris" ] )
                            , ( "Ravi", [ "Celine" ] )
                            , ( "Sofia", [ "Diego", "Elif" ] )
                            , ( "Tariq", [ "Farah" ] )
                            , ( "Uma", [ "Giorgio" ] )
                            , ( "Viktor", [ "Hana", "Ian" ] )
                            , ( "Wang", [ "Jing" ] )
                            , ( "Xiomara", [ "Kaito" ] )
                            , ( "Yuki", [ "Leila" ] )
                            , ( "Zane", [ "Mateo" ] )
                            , ( "Aditi", [ "Nia" ] )
                            , ( "Boris", [ "Oscar" ] )
                            , ( "Celine", [ "Priya" ] )
                            , ( "Diego", [ "Qi" ] )
                            , ( "Elif", [ "Rami" ] )
                            , ( "Farah", [ "Sven" ] )
                            , ( "Giorgio", [ "Tomoko" ] )
                            , ( "Hana", [ "Umar" ] )
                            , ( "Ian", [ "Vera" ] )
                            , ( "Jing", [ "Wyatt" ] )
                            , ( "Kaito", [ "Xia" ] )
                            , ( "Leila", [ "Yassin" ] )
                            , ( "Mateo", [ "Zara" ] )
                            , ( "Nia", [ "Antonio" ] )
                            , ( "Oscar", [ "Bianca" ] )
                            , ( "Priya", [ "Cai" ] )
                            , ( "Qi", [ "Dimitri" ] )
                            , ( "Rami", [ "Ewa" ] )
                            , ( "Sven", [ "Fabio" ] )
                            , ( "Tomoko", [ "Gabriela" ] )
                            , ( "Umar", [ "Helena" ] )
                            , ( "Vera", [ "Igor" ] )
                            , ( "Wyatt", [ "Jun" ] )
                            , ( "Xia", [ "Kim" ] )
                            , ( "Yassin", [ "Lucia" ] )
                            , ( "Zara", [ "Mohammed" ] )
                            ]
                        )
                        "Dimitri"
                        "Fabio"
                        |> Expect.equal 9
        , skip <|
            test "Complex graph, no shortcut, far removed nephew" <|
                \() ->
                    RelativeDistance.degreeOfSeparation
                        (Dict.fromList
                            [ ( "Aiko", [ "Bao", "Carlos" ] )
                            , ( "Bao", [ "Dalia", "Elias" ] )
                            , ( "Carlos", [ "Fatima", "Gustavo" ] )
                            , ( "Dalia", [ "Hassan", "Isla" ] )
                            , ( "Elias", [ "Javier" ] )
                            , ( "Fatima", [ "Khadija", "Liam" ] )
                            , ( "Gustavo", [ "Mina" ] )
                            , ( "Hassan", [ "Noah", "Olga" ] )
                            , ( "Isla", [ "Pedro" ] )
                            , ( "Javier", [ "Quynh", "Ravi" ] )
                            , ( "Khadija", [ "Sofia" ] )
                            , ( "Liam", [ "Tariq", "Uma" ] )
                            , ( "Mina", [ "Viktor", "Wang" ] )
                            , ( "Noah", [ "Xiomara" ] )
                            , ( "Olga", [ "Yuki" ] )
                            , ( "Pedro", [ "Zane", "Aditi" ] )
                            , ( "Quynh", [ "Boris" ] )
                            , ( "Ravi", [ "Celine" ] )
                            , ( "Sofia", [ "Diego", "Elif" ] )
                            , ( "Tariq", [ "Farah" ] )
                            , ( "Uma", [ "Giorgio" ] )
                            , ( "Viktor", [ "Hana", "Ian" ] )
                            , ( "Wang", [ "Jing" ] )
                            , ( "Xiomara", [ "Kaito" ] )
                            , ( "Yuki", [ "Leila" ] )
                            , ( "Zane", [ "Mateo" ] )
                            , ( "Aditi", [ "Nia" ] )
                            , ( "Boris", [ "Oscar" ] )
                            , ( "Celine", [ "Priya" ] )
                            , ( "Diego", [ "Qi" ] )
                            , ( "Elif", [ "Rami" ] )
                            , ( "Farah", [ "Sven" ] )
                            , ( "Giorgio", [ "Tomoko" ] )
                            , ( "Hana", [ "Umar" ] )
                            , ( "Ian", [ "Vera" ] )
                            , ( "Jing", [ "Wyatt" ] )
                            , ( "Kaito", [ "Xia" ] )
                            , ( "Leila", [ "Yassin" ] )
                            , ( "Mateo", [ "Zara" ] )
                            , ( "Nia", [ "Antonio" ] )
                            , ( "Oscar", [ "Bianca" ] )
                            , ( "Priya", [ "Cai" ] )
                            , ( "Qi", [ "Dimitri" ] )
                            , ( "Rami", [ "Ewa" ] )
                            , ( "Sven", [ "Fabio" ] )
                            , ( "Tomoko", [ "Gabriela" ] )
                            , ( "Umar", [ "Helena" ] )
                            , ( "Vera", [ "Igor" ] )
                            , ( "Wyatt", [ "Jun" ] )
                            , ( "Xia", [ "Kim" ] )
                            , ( "Yassin", [ "Lucia" ] )
                            , ( "Zara", [ "Mohammed" ] )
                            ]
                        )
                        "Lucia"
                        "Jun"
                        |> Expect.equal 14
        , skip <|
            test "Complex graph, some shortcuts, cross-down and cross-up, cousins several times removed, with unrelated family tree" <|
                \() ->
                    RelativeDistance.degreeOfSeparation
                        (Dict.fromList
                            [ ( "Aiko", [ "Bao", "Carlos" ] )
                            , ( "Bao", [ "Dalia" ] )
                            , ( "Carlos", [ "Fatima", "Gustavo" ] )
                            , ( "Dalia", [ "Hassan", "Isla" ] )
                            , ( "Fatima", [ "Khadija", "Liam" ] )
                            , ( "Gustavo", [ "Mina" ] )
                            , ( "Hassan", [ "Noah", "Olga" ] )
                            , ( "Isla", [ "Pedro" ] )
                            , ( "Javier", [ "Quynh", "Ravi" ] )
                            , ( "Khadija", [ "Sofia" ] )
                            , ( "Liam", [ "Tariq", "Uma" ] )
                            , ( "Mina", [ "Viktor", "Wang" ] )
                            , ( "Noah", [ "Xiomara" ] )
                            , ( "Olga", [ "Yuki" ] )
                            , ( "Pedro", [ "Zane", "Aditi" ] )
                            , ( "Quynh", [ "Boris" ] )
                            , ( "Ravi", [ "Celine" ] )
                            , ( "Sofia", [ "Diego", "Elif" ] )
                            , ( "Tariq", [ "Farah" ] )
                            , ( "Uma", [ "Giorgio" ] )
                            , ( "Viktor", [ "Hana", "Ian" ] )
                            , ( "Wang", [ "Jing" ] )
                            , ( "Xiomara", [ "Kaito" ] )
                            , ( "Yuki", [ "Leila" ] )
                            , ( "Zane", [ "Mateo" ] )
                            , ( "Aditi", [ "Nia" ] )
                            , ( "Boris", [ "Oscar" ] )
                            , ( "Celine", [ "Priya" ] )
                            , ( "Diego", [ "Qi" ] )
                            , ( "Elif", [ "Rami" ] )
                            , ( "Farah", [ "Sven" ] )
                            , ( "Giorgio", [ "Tomoko" ] )
                            , ( "Hana", [ "Umar" ] )
                            , ( "Ian", [ "Vera" ] )
                            , ( "Jing", [ "Wyatt" ] )
                            , ( "Kaito", [ "Xia" ] )
                            , ( "Leila", [ "Yassin" ] )
                            , ( "Mateo", [ "Zara" ] )
                            , ( "Nia", [ "Antonio" ] )
                            , ( "Oscar", [ "Bianca" ] )
                            , ( "Priya", [ "Cai" ] )
                            , ( "Qi", [ "Dimitri" ] )
                            , ( "Rami", [ "Ewa" ] )
                            , ( "Sven", [ "Fabio" ] )
                            , ( "Tomoko", [ "Gabriela" ] )
                            , ( "Umar", [ "Helena" ] )
                            , ( "Vera", [ "Igor" ] )
                            , ( "Wyatt", [ "Jun" ] )
                            , ( "Xia", [ "Kim" ] )
                            , ( "Yassin", [ "Lucia" ] )
                            , ( "Zara", [ "Mohammed" ] )
                            ]
                        )
                        "Wyatt"
                        "Xia"
                        |> Expect.equal 12
        ]
