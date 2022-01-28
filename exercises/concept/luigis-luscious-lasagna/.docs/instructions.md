# Instructions

In this exercise you're going to write some code to help you cook a brilliant lasagna from your favorite cooking book.

Your housemate is still busy at the office, and wants to know what time the lasagna will be ready, so that she can make sure she is back in time.

## 1. Work out what time the lasagna will be ready

Create a function to work out what time the lasagna will be ready. To make the code simple and expressive you should use a `let` expression.

Define the `expectedMinutesInOven` constant (in the `let` part of the `let` expression) to check how many minutes the lasagna should be in the oven. According to the cooking book, the expected oven time in minutes is 40:

```elm
expectedMinutesInOven
    --> 40
```

Define the `preparationTimeInMinutes` constant (in the `let` part of the `let` expression) that takes the number of layers you added to the lasagna as a parameter and returns how many minutes you spent preparing the lasagna, assuming each layer takes you 2 minutes to prepare.

```elm
preparationTimeInMinutes 3
    --> 6
```

Define the `remainingTimeInMinutes` function (in the `in` part of the `let` expression) that takes two parameters: the first parameter is the number of layers you added to the lasagna, and the second parameter is the number of minutes since you starting cooking. The function should return how many minutes are left until the lasagna is finished, which is the sum of the `preparationTimeInMinutes` and the `expectedMinutesInOven` minus the number of minutes since you starting cooking.

```elm
remainingTimeInMinutes 3 10
    --> 6 + 40 - 10 = 36
```
