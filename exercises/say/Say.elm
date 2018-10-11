module Say exposing (SayError(..), say)


type SayError
    = Negative
    | TooLarge


say : Int -> Result SayError String
say number =
    Debug.todo "Please implement this function"
