module Triangle exposing (Triangle(..), triangleKind)

import Set


type Triangle
    = Equilateral
    | Isosceles
    | Scalene


triangleKind : number -> number -> number -> Result String Triangle
triangleKind x y z =
    if x <= 0 || y <= 0 || z <= 0 then
        Err "Invalid lengths"

    else if x + y <= z || x + z <= y || y + z <= x then
        Err "Violates inequality"

    else
        case Set.size (Set.fromList [ x, y, z ]) of
            1 ->
                Ok Equilateral

            2 ->
                Ok Isosceles

            _ ->
                Ok Scalene
