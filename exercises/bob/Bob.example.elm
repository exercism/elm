module Bob exposing (..)

import Regex
import String


hey : String -> String
hey remark =
    if isShouting remark then
        "Whoa, chill out!"
    else if isQuestion remark then
        "Sure."
    else if isSilence remark then
        "Fine. Be that way!"
    else
        "Whatever."


isShouting : String -> Bool
isShouting remark =
    isUppercase remark && hasCharacters remark


isUppercase : String -> Bool
isUppercase remark =
    remark == String.toUpper remark


isQuestion : String -> Bool
isQuestion remark =
    String.endsWith "?" remark


hasCharacters : String -> Bool
hasCharacters remark =
    Regex.contains characterRegex remark


characterRegex : Regex.Regex
characterRegex =
    Regex.regex "[a-zA-Z]"


isSilence : String -> Bool
isSilence remark =
    String.isEmpty (String.trim remark)
