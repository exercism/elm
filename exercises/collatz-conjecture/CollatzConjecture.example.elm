module CollatzConjecture exposing (collatz)


collatz : Int -> Result String Int
collatz start =
    if start <= 0 then
        Err "Only positive numbers are allowed"
    else
        Ok (collatzHelper 0 start)


collatzHelper : Int ->  Int -> Int
collatzHelper steps start =
    if start == 1 then
        steps
    else if start % 2 == 0 then
        collatzHelper (1 + steps) (start // 2)
    else
        collatzHelper (1 + steps) (3 * start + 1)
