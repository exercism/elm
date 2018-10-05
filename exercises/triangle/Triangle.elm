module Triangle exposing (Triangle(..), triangleKind)


type Triangle
    = Equilateral
    | Isosceles
    | Scalene


triangleKind : comparable -> comparable -> comparable -> Result String Triangle
triangleKind x y z =
    Debug.crash "Please implement this function"
