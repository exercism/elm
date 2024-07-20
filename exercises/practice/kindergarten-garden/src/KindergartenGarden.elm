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
    Debug.todo "Please implement plants"
