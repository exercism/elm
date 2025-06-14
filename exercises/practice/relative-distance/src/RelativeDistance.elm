module RelativeDistance exposing (degreeOfSeparation)

import Dict exposing (Dict)


degreeOfSeparation : Dict String (List String) -> String -> String -> Maybe Int
degreeOfSeparation familyTree personA personB =
    Debug.todo "Please implement degreeOfSeparation"
