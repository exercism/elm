module KindergartenGarden exposing (Plant(..), Student(..), plants)


type Student
    = Alice
    | Bob
    | Charlie
    | David
    | Eve
    | Fred
    | Ginny
    | Harriet
    | Ileana
    | Joseph
    | Kincaid
    | Larry


type Plant
    = Grass
    | Clover
    | Radish
    | Violet


plants : String -> Student -> List Plant
plants diagram student =
    diagram
        |> String.split "\n"
        |> List.concatMap (takeCupsInRow student)
        |> List.map decodeToPlant


decodeToPlant : Char -> Plant
decodeToPlant char =
    case char of
        'G' ->
            Grass

        'C' ->
            Clover

        'R' ->
            Radish

        'V' ->
            Violet

        _ ->
            Grass


cupNumber : Student -> Int
cupNumber student =
    case student of
        Alice ->
            0

        Bob ->
            2

        Charlie ->
            4

        David ->
            6

        Eve ->
            8

        Fred ->
            10

        Ginny ->
            12

        Harriet ->
            14

        Ileana ->
            16

        Joseph ->
            18

        Kincaid ->
            20

        Larry ->
            22


takeCupsInRow : Student -> String -> List Char
takeCupsInRow student row =
    let
        number =
            cupNumber student
    in
    row
        |> String.slice number (number + 2)
        |> String.toList
