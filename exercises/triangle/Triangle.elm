module Triangle exposing (Triangle(..), triangleKind, version)


type Triangle
    = Equilateral
    | Isosceles
    | Scalene


version : Int
version =
    2


triangleKind : comparable -> comparable -> comparable -> Result String Triangle
triangleKind x y z =
    Debug.crash "Please implement this function"
