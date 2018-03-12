module Say exposing (SayError(..), say)


type SayError
    = Negative
    | TooLarge


say : Int -> Result SayError String
say number =
    Debug.crash "Please implement this function"
