# About

The `Bool` type is one of the building blocks of the language.
It aims at describing whether something is true or false, with the respective `True` and `False` values.
The name `Bool` is short for Boolean, which is a field of mathematics related to logical thinking, named after the work of George Boole.

## Boolean operators

There are two functions and two operators to manipulate values of type `Bool`.

- `not : Bool -> Bool`
  This function transforms `True` into `False` and `False` into `True`.
- `(&&) : Bool -> Bool -> Bool`
  This operator called "AND" takes two booleans and returns `True` if they are both `True`.
  For example, `True && True` returns `True` but `True && False` returns `False`.
- `(||) : Bool -> Bool -> Bool`
  This operator called "OR" takes two booleans and returns `True` if at least one of them is `True`.
  For example, `False || False` returns `False` but `True || False` returns `True`.
- `xor : Bool -> Bool -> Bool`
  This function (not operator) called "XOR" takes two booleans and returns `True` if and only if one is `True` and the other is `False`.

The `&&` and `||` operators do not have the same priority.
The priority of `&&` is higher than the one of `||`, just like with multiplication `*` and addition `+`.
As a consequence, the expression `True || False && False` is equivalent to `True || (False && False)` which is different from `(True || False) && False`.
While the former returns `True` the latter returns `False`.

## Conditional branching

Booleans are extremely useful to make branches in your code that only get executed if certain conditions are met.
In Elm, this is done with an `if-then-else` expression, used as follows.

```elm
if someCondition then
    doSomething
else
    doSomethingElse
```

The value `someCondition` can be any expression that returns a `Bool`.
If that boolean value is `True`, the code will execute `doSomething`.
Otherwise it is `False` and the code will execute `doSomethingElse`.
The `else` branch is mandatory, contrary to some other programming languages.

If you need to chain conditions, you can just chain the `if-then-else` expressions.

```elm
if someCondition then
    doSomething
else if someOtherCondition then
    doAnotherThing
else
    doSomethingElse
```
