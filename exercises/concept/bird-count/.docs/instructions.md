# Instructions

You're an avid bird watcher that keeps track of how many birds have visited your garden on any given day.

You decided to bring your bird watching to a new level and implement a few tools that will help you track and process the data.

You have chosen to store the data as a list of integers.
The first number in the list is the number of birds that visited your garden today, the second yesterday, and so on.

```exercism/note
In real-world applications, you should always use core modules whenever applicable, however for the purpose of learning about recursion, do not use any of the `List` functions in this exercise.
```

## 1. Check how many birds visited today

Implement the `today` function.
It should take a list of daily bird counts and return today's count.
If the list is empty, it should return `Nothing`, otherwise the count will be wrapped in a `Just`.

```elm
BirdCount.today [2, 5, 1]
    -- Just 2
```

## 2. Increment today's count

Implement the `incrementDayCount` function.
It should take a list of daily bird counts and increment today's count by 1.
If the list is empty, return `[1]`.

```elm
BirdCount.incrementDayCount [4, 0, 2]
    -- [5, 0, 2]
```

## 3. Check if there was a day with no visiting birds

Implement the `hasDayWithoutBirds` function.
It should take a list of daily bird counts.
It should return `True` if there was at least one day when no birds visited the garden, and `False` otherwise.

```elm
BirdCount.hasDayWithoutBirds [2, 0, 4]
    -- True

BirdCount.hasDayWithoutBirds [3, 8, 1, 5]
    -- False
```

## 4. Calculate the total number of visiting birds

Implement the `total` function.
It should take a list of daily bird counts and return the total number that visited your garden since you started collecting the data.

```elm
BirdCount.total [4, 0, 9, 0, 5]
    -- 18
```

## 5. Calculate the number of busy days

Some days are busier than others.
A busy day is one where five or more birds have visited your garden.

Implement the `busyDays` function.
It should take a list of daily bird counts and return the number of busy days.

```elm
BirdCount.busyDays [4, 5, 0, 0, 6]
    -- 2
```
