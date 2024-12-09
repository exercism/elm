module SecretHandshake exposing (Command(..), commands)


type Command
    = Wink
    | DoubleBlink
    | CloseYourEyes
    | Jump


commands : Int -> List Command
commands number =
    Debug.todo "Please implement commands"
