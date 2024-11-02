# Bitwise Operations

Bitwise operations allow us to manipulate individual digits within binary numbers. These operations are fundamental in computing, providing an efficient way to perform low-level tasks, such as controlling specific bits in memory, optimizing mathematical calculations, and encoding/decoding data.

## Understanding 32-bit Integers in Elm
In Elm, integers are stored as 32-bit signed integers using [two's complement](https://en.wikipedia.org/wiki/Two%27s_complement) representation, meaning they use 32 binary digits (_bits_) to store each integer value. This bit limit affects the range of integers that Elm can represent directly:

Positive Range: 0 to 2<sup>^31</sup> - 1 (or 0 to 2,147,483,647)
Negative Range: -2<sup>^31</sup> to -1 (or -2,147,483,648 to -1)

For example, the integer `5` is represented in binary as `00000000000000000000000000000101`, although usually we ignore the leading zeros and just say `101`.

## Bitwise operations
Elm provides several bitwise operators in its [Bitwise module](https://package.elm-lang.org/packages/elm/core/latest/Bitwise)

## Basic operations

### and
`and` combines two numbers by keeping only the bits that are `1` in both. For example:

```elm
Bitwise.and 21 13 --> 5
--  21 = 10101
--  13 = 01101
-- and = 00101 = 5
```
 This is useful for checking to see if an individual bit is set. For example, to check if the 4th bit of a number is set to `1`, `and` it with `01000` (`8` in decimal) and see if the result is non-zero:

 ```elm
 Bitwise.and 13 8 --> 8
 --  13 = 01101
 --   8 = 01000
 -- and = 01000 = 8

 Bitwise.and 21 8 -> 0
 -- 21  = 10101
 --  8  = 01000
 -- and = 00000 = 0
 ```

### or
`or` combines two numbers by setting each bit to `1` if it is `1` in either or both numbers.

```elm
Bitwise.or 21 13 --> 29
-- 21 = 10101
-- 13 = 01101
-- or = 11101 = 29
```
This is useful for setting a specific bit to `1`. For example, to set the 2nd bit in `10101`:

```elm
Bitwise.or 21 2 --> 23
-- 21 = 10101
--  2 = 00010
-- or = 10111 = 23
```

### Exclusive-or (xor)
`xor` combines two numbers by setting each bit to `1` if it is `1` in one number but `0` in the other.

```elm
Bitwise.xor 21 13 --> 24
--  21 = 10101
--  13 = 01101
-- xor = 11000 = 24
```
This is useful for flipping a bit to its opposite value:

```elm
Bitwise.xor 21 4 --> 17
--  21 = 10101
--   4 = 00100
-- xor = 10001 = 17

Bitwise.xor 17 4 --> 21
--  17 = 10001
--   4 = 00100
-- xor = 10101 = 21
```

### Complement
`complement` inverts each bit of a number (`0` becomes `1`, `1` becomes `0`). 

Note that this will result in positive numbers becoming negative, and negative numbers becoming positive. This is because negative numbers in binary are represented with `1` in the left-most position.

```elm
Bitwise.complement 21 --> -22
--         21 = 00000000000000000000000000010101
-- complement = 11111111111111111111111111101010 = -22
```

## Bit shifting
The following operators move bits left or right by a specified number of positions, effectively multiplying or dividing by powers of 2.

`shiftLeftBy` moves bits to the left, filling in with `0` from the right-hand side. For example, to shift `21` left by 3 places:

```elm
Bitwise.shiftLeftBy 3 21 --> 168
--  21 = 10101
-- shiftLeftBy 3 = 10101000 = 168
```
This is the same as saying `21 * 2^3 = 21 * 2 * 2 * 2 = 168`

`shiftRightBy`: Moves bits to the right:
```elm
Bitwise.shiftRightBy 2 21 --> 5
--  21 = 10101
-- shiftRightBy 2 = 00101 = 5
```
Shifiting to the right by 2 places is the same as integer division by 4.

Note that this function duplicates whatever value is in the leftmost bit. So negative numbers will stay negative:

```elm
Bitwise.shiftRightBy 3 -21 --> -6
--  -21 = 111...10101
-- shiftRightBy 3 = 111...11101 = -6
```

If you want to shift right and fill in with zeros, use `shiftRightZfBy`:
```elm
Bitwise.shiftRightZfBy 3 -21 --> 1073741818
--  -21 = 111...10101
-- shiftRightBy 3 = 00111...11101 = 1073741818
```