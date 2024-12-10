module Secrets exposing (clearBits, decrypt, flipBits, setBits, shiftBack)

import Bitwise


shiftBack amount value =
    Bitwise.shiftRightZfBy amount value


setBits mask value =
    Bitwise.or mask value


flipBits mask value =
    Bitwise.xor mask value


clearBits mask value =
    mask
        |> Bitwise.complement
        |> Bitwise.and value


decrypt secret =
    secret
        |> setBits 1996
        |> flipBits 2009
        |> shiftBack 5
        |> clearBits 17
