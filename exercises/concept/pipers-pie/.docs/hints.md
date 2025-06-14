# Hints

## General

- You can read about [Tail Call Elimination][tail-call-elimination] from the creator of Elm
- In tail recursive functions, the _last_ operation in a branch calls itself in a simple function application
- You will need to define tail recursive helper functions

## 1. Factorial

- You will need to define a tail recursive helper function
- The factorial of 0 is 1
- Use recursion to reduce `n` to its base case, while keeping track of the product

## 2. Double Factorial

- You will need to define a tail recursive helper function
- The double factorial of 0 is 1
- The double factorial of 1 is 1
- Use recursion to reduce `n`, two by two, to its base case, while keeping track of the product

## 3. Newton/Euler Convergence Transformation

- You will need to define a tail recursive helper function
- Using `factorial` and `doubleFactorial` directly is discouraged, as it is not the most efficient way to create the terms of the sum
- You can pass as many arguments as you wish to the helper function

[tail-call-elimination]: https://functional-programming-in-elm.netlify.app/recursion/tail-call-elimination.html
