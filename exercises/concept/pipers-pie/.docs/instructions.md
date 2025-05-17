# Instructions

Piper is an avid pie baker.

No one knows if she picked pie baking because of her name, or if she changed her name to match her hobby.
At a glance, the latter doesn't seem very likely, but you see, Piper is absolutely fascinated by pies.
She's always tinkering in the kitchen, tweaking her recipes, improving her craft, to the absolute delight of her friends.

Her latest interest?
Baking pies as circular as possible, to the point of mathematical perfection, with the help of her favorite number, you guessed it: π.

Piper found a delightful formula to calculate π iteratively, the Newton/Euler Convergence Transformation:

```
π / 2 = sum for k from 0 to infinity of ( k! ) / ( 2 * k + 1 )!!
```

Help Piper bake her mathematically perfect pie by calculating π.

## 1. Factorial

Let's warm up first.
The factorial operator, usually written `!`, is defined as

```
0! = 1
n! = 1 * 2 * 3 * ... * n
```

Define the `factorial` function which will compute the factorial in a tail recursive manner.

```elm
factorial 4
    -- 24
```

## 2. Double Factorial

The double factorial operator, usually written `!!`, is defined as

```
0!! = 1
n!! = 1 * 3 * 5 * ... * n (for odd n)
n!! = 2 * 4 * 6 * ... * n (for even n)
```

Define the `doubleFactorial` function which will compute the factorial in a tail recursive manner.

```elm
factorial 5
    -- 15
factorial 6
    -- 48
```

## 3. Newton/Euler Convergence Transformation

Define the `pipersPi` function, which will approximate π using a set number of terms from the Newton/Euler Convergence Transformation formula in a tail recursive manner.

```
π / 2 = sum for k from 0 to infinity of ( k! ) / ( 2 * k + 1 )!!
```

Let's compute the first term together.
For an upper limit of `0` (instead of infinity), we get:

```
π / 2 ≈ Sum for k from 0 to 0 of ( k! ) / ( 2 * k + 1 )!!
π / 2 ≈ ( 0! ) / ( 2 * 0 + 1 )!!
π / 2 ≈ 0! / 0!!
π / 2 ≈ 1 / 1
π / 2 ≈ 1
π ≈ 2
```

Each extra term will improve the approximation.

```elm
pipersPi 0
    -- 2.0
pipersPi 1
    -- 2.6666666
```
