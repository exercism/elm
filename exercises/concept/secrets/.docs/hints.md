# Hints

- The documentation for the `Bitwise` package can be found [here][bitwise-docs].

## 1. Shift back the bits

- There are two functions for shifting bits to the right, but [only one][bitwise-shiftRightZfBy] will always insert a 0.

## 2. Set some bits

- [One of the bitwise functions][bitwise-or] will always set a bit to 1 where the bits in both values are 1.

## 3. Flip specific bits

- There is [a bitwise function][bitwise-xor] that will flip a bit where the mask is 1.

## 4. Clear specific bits

- [One of the bitwise functions][bitwise-and] clears bits where the bit in the mask is 0.
- But, you may need to combine it with [another function][bitwise-complement] to clear bits where the mask is 1.

[bitwise-docs]: https://package.elm-lang.org/packages/elm/core/latest/Bitwise
[bitwise-shiftRightZfBy]: https://package.elm-lang.org/packages/elm/core/latest/Bitwise#shiftRightZfBy
[bitwise-or]: https://package.elm-lang.org/packages/elm/core/latest/Bitwise#or
[bitwise-xor]: https://package.elm-lang.org/packages/elm/core/latest/Bitwise#xor
[bitwise-complement]: https://package.elm-lang.org/packages/elm/core/latest/Bitwise#complement
[bitwise-and]: https://package.elm-lang.org/packages/elm/core/latest/Bitwise#and
