module Allergies exposing (Allergy(..), isAllergicTo, toList)


type Allergy
    = Eggs
    | Peanuts
    | Shellfish
    | Strawberries
    | Tomatoes
    | Chocolate
    | Pollen
    | Cats


isAllergicTo : Allergy -> Int -> Bool
isAllergicTo allergy score =
    Debug.todo "Please implement this function"


toList : Int -> List Allergy
toList score =
    Debug.todo "Please implement this function"
