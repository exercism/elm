# Introduction

Tuples in Elm can hold two or three values, and each value can have any type.
In Elm, Tuples are mostly used for simple transient types.
For this reason Tuples have a maximum of 3 values, and as a further encouragement convenience functions are only supplied for 2 values.
For more complex data, it is best to switch to records.
A common use is if you need to return more than one value from a function.
Tuple fields don't have names, they are accessed by destructuring or by position.
