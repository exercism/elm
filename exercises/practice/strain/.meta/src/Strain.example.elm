module Strain exposing (discard, keep)

import List


keep : (a -> Bool) -> List a -> List a
keep =
    List.filter


discard : (a -> Bool) -> List a -> List a
discard predicate list =
    List.foldr (consIf (\v -> not <| predicate v)) [] list


consIf : (a -> Bool) -> a -> List a -> List a
consIf predicate value list =
    if predicate value then
        value :: list

    else
        list
