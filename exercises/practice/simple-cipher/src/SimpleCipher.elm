module SimpleCipher exposing (decode, encode, keyGen)

import Random exposing(Generator)

encode : String -> String -> String
encode key plaintext =
    Debug.todo "Please implement encode"


decode : String -> String -> String
decode key ciphertext =
    Debug.todo "Please implement decode"


keyGen : Generator String
keyGen =
    Random.lazy (\_ -> Debug.todo "Please implement keyGen")
