# Introduction

The `Bool` type is one of the building blocks of the language.
It aims at describing whether something is true or false, with the respective `True` and `False` values.

Booleans can be combined with the `&&` "AND" and the `||` "OR" operators, and negated with the `not` function.

Booleans are also extremely useful to make branches in your code that only get executed if certain conditions are met.
In Elm, this is done with an `if-then-else` expression, used as follows.

```elm
if someCondition || (someOtherCondition && anotherCondition) then
    doSomething
else
    doSomethingElse
```
