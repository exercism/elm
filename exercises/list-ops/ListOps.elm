module ListOps
    exposing
        ( append
        , concat
        , filter
        , foldl
        , foldr
        , length
        , map
        , reverse
        )


length : List a -> Int
length list =
    Debug.crash "Please implement this function"


reverse : List a -> List a
reverse list =
    Debug.crash "Please implement this function"


foldl : (a -> b -> b) -> b -> List a -> b
foldl f acc list =
    Debug.crash "Please implement this function"


foldr : (a -> b -> b) -> b -> List a -> b
foldr f acc list =
    Debug.crash "Please implement this function"


map : (a -> b) -> List a -> List b
map f list =
    Debug.crash "Please implement this function"


filter : (a -> Bool) -> List a -> List a
filter f list =
    Debug.crash "Please implement this function"


append : List a -> List a -> List a
append xs ys =
    Debug.crash "Please implement this function"


concat : List (List a) -> List a
concat list =
    Debug.crash "Please implement this function"
