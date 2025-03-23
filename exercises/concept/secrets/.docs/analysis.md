# Analysis for Concept Exercise: Secrets

This exercise challenges you to work with Elm’s [Bitwise module](https://package.elm-lang.org/packages/elm/core/latest/Bitwise) by implementing several functions that manipulate bits. Through this exercise, you will deepen your understanding of binary encoding, bit masks, and basic bitwise operations.

## Overview

The goal of the exercise is to implement five functions that manipulate integers at the binary level:

1. **shiftBack**: Shifts bits to the right, inserting zeros on the left.
2. **setBits**: Sets specific bits to 1 using a mask.
3. **flipBits**: Flips specific bits according to a mask.
4. **clearBits**: Clears specific bits (sets them to 0) using a mask.
5. **decrypt**: Combines all the previous functions to decrypt an input number by applying the operations in a specific order.

In addition to practicing bitwise operations, you will also see how small functions can be composed to build a more complex transformation.

## Function-by-Function Analysis

### 1. shiftBack

- **Objective:** Reverse an earlier left shift by moving the bits to the right.
- **Expected Behavior:** 
  - `shiftBack 2 8` should result in `2`.
  - When shifting a negative number like `-8`, the correct right shift with zero-fill is required to match the expected output (e.g., `shiftBack 2 -8` equals `1073741822`).
- **Implementation Hint:**  
  Use the function `Bitwise.shiftRightZfBy` since it always fills in zeros, even for negative numbers.

### 2. setBits

- **Objective:** Set bits in the input number to `1` based on the mask.
- **Expected Behavior:** 
  - For example, `setBits 3 5` should yield `7` (because applying the mask sets additional bits to 1).
- **Implementation Hint:**  
  Use the bitwise `or` operation (`Bitwise.or`). This operation ensures that any bit that is 1 in the mask will be 1 in the result.

### 3. flipBits

- **Objective:** Flip (invert) certain bits in the input number as indicated by the mask.
- **Expected Behavior:** 
  - For instance, `flipBits 11 5` should produce `14`.
- **Implementation Hint:**  
  Use the bitwise `xor` operation (`Bitwise.xor`), which inverts a bit if the corresponding mask bit is set.

### 4. clearBits

- **Objective:** Clear (set to 0) specific bits in the input number based on the mask.
- **Expected Behavior:** 
  - For example, `clearBits 11 5` should yield `4`.
- **Implementation Hint:**  
  First, compute the complement of the mask with `Bitwise.complement` to invert the mask, then use `Bitwise.and` to ensure that only the desired bits remain.

### 5. decrypt

- **Objective:** Decrypt a secret number by combining the previous operations.
- **Decryption Steps:**
  1. **Set bits:** Apply `setBits` with the mask `1996` (the year the friend was born).
  2. **Flip bits:** Use `flipBits` with the mask `2009` (the year you first met).
  3. **Shift back:** Apply `shiftBack` by `5` (the number of classes taken together).
  4. **Clear bits:** Finally, apply `clearBits` with the mask corresponding to the binary `10001` (which is `17` in decimal).
- **Expected Behavior:**  
  - `decrypt 12345` should yield `384`.
  - `decrypt 123456789` should yield `3857984`.
- **Implementation Hint:**  
  Make sure that your `decrypt` function calls **all** the previously defined functions in the exact order specified.

## Bitwise Operations Recap

- **Shift Operations:**  
  Shifting bits to the right using `shiftRightZfBy` ensures that the left-hand side is padded with zeros.
- **Masking:**  
  - **OR (`|`)**: Sets bits to 1.
  - **XOR (`^`)**: Flips bits.
  - **AND (`&`)**: Can be used to clear bits when combined with a complemented mask.
- **Complement:**  
  The `complement` function inverts the bits of a number, which is especially useful when you want to clear bits (i.e., set them to 0) where the mask has 1s.

## Testing & Expected Results

The provided tests ensure that your functions behave correctly:
- **shiftBack:**  
  Checks for both positive and negative numbers.
- **setBits, flipBits, clearBits:**  
  Verify that each operation correctly manipulates bits as intended.
- **decrypt:**  
  Confirms that the chain of operations yields the correct decrypted message.

The test cases act as both a specification and a safeguard against common mistakes (such as incorrect ordering or misusing a bitwise operation).

## Conclusion

By decomposing a complex decryption algorithm into smaller, manageable functions, you learn how to use Elm’s `Bitwise` module and how to think about data at the binary level. This understanding is fundamental not only for this exercise but also for other domains where performance and low-level data manipulation are critical.
