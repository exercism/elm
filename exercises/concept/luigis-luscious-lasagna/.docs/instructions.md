# Instructions

You have been given a new cooking book for your birthday, and you want to find out if the lasagna recipe in it is better than your current favourite cooking book. In this exercise you're going to write some code to help you cook a the lasagna from the new cooking book.

Your housemate is still busy at the office, and wants to know what time the lasagna will be ready, so that she can make sure she is back in time.

## 1. Work out what time the lasagna will be ready

Create a function to work out what time the lasagna will be ready. To make the code simple and expressive you should use a `let` expression.

Define the `remainingTimeInMinutes` function that takes two parameters and has a let expression as its body. The first parameter is the number of layers in the lasagna, and the second parameter is the number of minutes since you starting cooking.

Define `expectedMinutesInOven` (in the `let` part of the `let` expression) to check how many minutes the lasagna should be in the oven. According to the cooking book, the expected oven time in minutes is 40:

```elm
expectedMinutesInOven
    --> 40
```

Define `preparationTimeInMinutes` (in the `let` part of the `let` expression) that takes the number of layers in the lasagna as a parameter and returns how many minutes it takes to prepare the lasagna, assuming each layer takes 2 minutes to prepare.

```elm
preparationTimeInMinutes 3
    --> 6
```

Return how many minutes are left until the lasagna is finished (in the `in` part of the `let` expression), which is the sum of the `preparationTimeInMinutes` and the `expectedMinutesInOven` minus the number of minutes since you starting cooking.

```elm
remainingTimeInMinutes 3 10
    --> 6 + 40 - 10 = 36
```
