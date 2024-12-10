# Instructions

Your friend has just sent you a message with an important secret.
Not wanting to make it easy for others to read it, the message was encrypted by performing a series of bit manipulations.
You will need to write the functions to help decrypt the message.

## 1. Shift back the bits

The first step in decrypting the message is to undo the shifting from the encryption process by shifting the bits back to the right.
There will be further steps in the decryption process that assume `0`s are inserted from the left hand side.

Implement the `shiftBack` function that takes a number of places to shift by and a value and peforms the shift.

```elm
shiftBack 2 42 --> 10
```

## 2. Set some bits

Next, there are some bits that need to be set to `1`.

Implement the `setBits` function that takes a mask and value and returns the result of setting the bits in value to `1`.
A bit from value should be set to `1` where the bit in the mask is also `1`.
All other bits should be kept unchanged.

```elm
setBits 66 212 --> 64
```

## 3. Flip specific bits

Some bits are flipped during encryption.
They will need to be flipped back to decrypt the message.

Implement the `flipBits` function that takes a mask and a value.
The mask indicates which bits in the value to flip.
If the bit is `1` in mask, the bit is flipped in the value.
All other bits are kept unchanged.

```elm
flipBits 23 157 --> 138
```

## 4. Clear specific bits

There are also certain bits that always decrypt to 0.

Implement the `clearBits` function that takes a mask and a value.
The bits in the `value` should be set to 0 where the bit in the mask is 1.
All other bits should be kept unchanged.

```elm
clearBits 2 15 --> 13
```

## 5. Decrypt a message

Now that you have all the functions you need, you can decode your friend's message.
Implement the `decrypt` function that performs the following operations:

1. Set the bits from the year your friend was born (1996)
2. Flip the result with the year that you first met (2009)
3. Shift the bits back by the number of classes you take together (5)
4. Clear the first and fifth bit.

```elm
decrypt 380182 --> 11840
```
