module Accumulate exposing (accumulate)


accumulate : (a -> b) -> List a -> List b
accumulate =
    List.map
