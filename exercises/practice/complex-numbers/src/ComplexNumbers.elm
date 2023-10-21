module ComplexNumbers exposing
    ( Complex
    , abs
    , add
    , conjugate
    , div
    , exp
    , fromPair
    , fromReal
    , imaginary
    , mul
    , real
    , sub
    )


type Complex
    = Todo


fromPair : ( Float, Float ) -> Complex
fromPair pair =
    Debug.todo "Please implement fromPair."


fromReal : Float -> Complex
fromReal float =
    Debug.todo "Please implement fromReal."


real : Complex -> Float
real z =
    Debug.todo "Please implement real."


imaginary : Complex -> Float
imaginary z =
    Debug.todo "Please implement imaginary."


conjugate : Complex -> Complex
conjugate z =
    Debug.todo "Please implement conjugate."


abs : Complex -> Float
abs z =
    Debug.todo "Please implement abs."


add : Complex -> Complex -> Complex
add z1 z2 =
    Debug.todo "Please implement add."


sub : Complex -> Complex -> Complex
sub z1 z2 =
    Debug.todo "Please implement sub."


mul : Complex -> Complex -> Complex
mul z1 z2 =
    Debug.todo "Please implement mul."


div : Complex -> Complex -> Complex
div z1 z2 =
    Debug.todo "Please implement div."


exp : Complex -> Complex
exp z =
    Debug.todo "Please implement exp."
