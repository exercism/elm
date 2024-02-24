module ProteinTranslation exposing (Error(..), proteins)


type Error
    = InvalidCodon


proteins : String -> Result Error (List String)
proteins strand =
    Debug.todo "Please implement proteins"
