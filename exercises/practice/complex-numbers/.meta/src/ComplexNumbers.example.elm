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
    = Complex Float Float


fromPair : ( Float, Float ) -> Complex
fromPair ( re, im ) =
    Complex re im


fromReal : Float -> Complex
fromReal re =
    Complex re 0


real : Complex -> Float
real (Complex re _) =
    re


imaginary : Complex -> Float
imaginary (Complex _ im) =
    im


conjugate : Complex -> Complex
conjugate (Complex re im) =
    Complex re -im


abs : Complex -> Float
abs (Complex re im) =
    sqrt (re ^ 2 + im ^ 2)


add : Complex -> Complex -> Complex
add (Complex re1 im1) (Complex re2 im2) =
    Complex (re1 + re2) (im1 + im2)


sub : Complex -> Complex -> Complex
sub (Complex re1 im1) (Complex re2 im2) =
    Complex (re1 - re2) (im1 - im2)


mul : Complex -> Complex -> Complex
mul (Complex re1 im1) (Complex re2 im2) =
    Complex (re1 * re2 - im1 * im2)
        (im1 * re2 + re1 * im2)


div : Complex -> Complex -> Complex
div (Complex re1 im1) (Complex re2 im2) =
    Complex ((re1 * re2 + im1 * im2) / (re2 ^ 2 + im2 ^ 2))
        ((im1 * re2 - re1 * im2) / (re2 ^ 2 + im2 ^ 2))


exp : Complex -> Complex
exp (Complex re im) =
    Complex (e ^ re * cos im) (e ^ re * sin im)
