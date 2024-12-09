module SecretHandshake exposing (Command(..), commands)

import Bitwise


type Command
    = Wink
    | DoubleBlink
    | CloseYourEyes
    | Jump
    | Reverse


commandToCode : Command -> Int
commandToCode command =
    case command of
        Wink ->
            1

        DoubleBlink ->
            2

        CloseYourEyes ->
            4

        Jump ->
            8

        Reverse ->
            16


commandApplies : Int -> Command -> Bool
commandApplies number command =
    Bitwise.and number (commandToCode command) > 0


commands : Int -> List Command
commands number =
    let
        maybeAction command =
            if commandApplies number command then
                Just command

            else
                Nothing

        actions =
            List.filterMap maybeAction [ Wink, DoubleBlink, CloseYourEyes, Jump ]
    in
    if commandApplies number Reverse then
        List.reverse actions

    else
        actions
