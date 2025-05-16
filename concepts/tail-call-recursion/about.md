# About

A function is [tail-recursive][recursion-tc] if the _last_ thing executed by the function is a call to itself.

Each time any function is called, a _stack frame_ with its local variables and arguments is put on top of [the function call stack][call-stack].
When a function returns, the stack frame is removed from the stack.

Tail-recursive functions allow for [tail call optimization][tail-call-optimization] (or tail call elimination).
It's an optimization that allows reusing the last stack frame by the next function call when the previous function is guaranteed not to need it anymore.
This mitigates concerns of overflowing the function call stack, which is a situation when there are so many frames on the function call stack that there isn't any memory left to create another one.

## Tail Call Optimization in Elm

Under some condition, the Elm compiler is able to automatically performs an a tail call optimization when compiling to JavaScript.

The optimization can happen for a recursive function when the _last_ operation in a branch is done by calling the function itself in a simple function application.
Let's look at some examples:

```elm
factorial : Int -> Int
factorial n =
  if n <= 1 then
    n
  else
    n * factorial (n-1)
```

The implementation above is not tail recursive, because the last operation in the `else` branch is a multiplication `n *`.

```elm
factorial : Int -> Int
factorial n =
  factorialHelper n n

factorialHelper : Int -> Int -> Int
factorialHelper n resultSoFar =
  if n <= 1 then
    resultSoFar
  else
    factorialHelper (n-1) (n * resultSoFar)
```

The implementation above is tail recursive and will be optimized, because the last operation in the `else` branch is `factorialHelper` calling itself.
This would not be possible for a function with the type signature `Int -> Int`, and in practice tail call optimization is often achieved by defining helper functions.

## Edge cases

In some cases, the compiler is not able to optimize recursive functions, let's look at some examples.

While `f x = f (x - 1)` is tail call recursive, `f x = (x - 1) |> f` is not, because the function application `|>` is the last operation and is considered separate from `f`.
Similarly, functions ending with boolean conditions `f x = x > 0 || f (x - 1)` are not tail recursive.

The function `f x = if f (x - 1) then 1 else 0` is not tail recursive, because the expression in the `if` is not considered to be a branch.
Similarly, a recursive call in a `case` statement would not be optimized either.

The function `f x = let y = f (x - 1) in y`, is not tail recursive because it calls itself in a `let` statement, which is not considered to be a branch.
However, in `f x = let g x = g (x - 1) in g x` the function `g` it tail recursive and will be optimized even though it's defined in a `let` statement.

The function `f x = if x > 0 then f (x + 1) else 1 + f x` will be _partially_ optimized: the `then` branch can be optimized but the `else` branch cannot.
Partial optimization is the best that can be achieved in some situations, such as traversing tree-like structures or defining co-recursive functions.

[recursion-tc]: https://en.wikipedia.org/wiki/Tail_call
[call-stack]: https://en.wikipedia.org/wiki/Call_stack
[tail-call-optimization]: https://jfmengels.net/tail-call-optimization/
