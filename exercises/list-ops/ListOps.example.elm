module ListOps exposing
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
    foldl (\_ acc -> 1 + acc) 0 list


reverse : List a -> List a
reverse list =
    foldl (::) [] list


foldl : (a -> b -> b) -> b -> List a -> b
foldl f acc list =
    case list of
        [] ->
            acc

        head :: tail ->
            foldl f (f head acc) tail


foldr : (a -> b -> b) -> b -> List a -> b
foldr f acc list =
    case list of
        [] ->
            acc

        head :: tail ->
            f head (foldr f acc tail)


map : (a -> b) -> List a -> List b
map f list =
    foldr (\x acc -> f x :: acc) [] list


filter : (a -> Bool) -> List a -> List a
filter f list =
    foldr
        (\x acc ->
            if f x then
                x :: acc

            else
                acc
        )
        []
        list


append : List a -> List a -> List a
append xs ys =
    foldr (::) ys xs


concat : List (List a) -> List a
concat list =
    foldr append [] list
