# Instructions

In this exercise you're going to write some code to help you cook a brilliant lasagna from your favorite cookbook.

You have three tasks, all related to the time spent cooking the lasagna.

## 1. Define the expected oven time in minutes

Define `expectedMinutesInOven` to calculate how many minutes the lasagna should be in the oven. According to the cookbook, the expected oven time in minutes is 40:

```elm
expectedMinutesInOven
    --> 40
```

## 2. Calculate the preparation time in minutes

Define `preparationTimeInMinutes` that takes the number of layers in the lasagna as a parameter and returns how many minutes it takes to prepare the lasagna, assuming each layer takes 2 minutes to prepare.

```elm
preparationTimeInMinutes 3
    --> 6
```

## 3. Calculate the elapsed time in minutes

Define the `elapsedTimeInMinutes` function that takes two parameters: the first parameter is the number of layers in the lasagna, and the second parameter is the number of minutes the lasagna has been in the oven. The function should return how many minutes you've worked on cooking the lasagna, which is the sum of the preparation time in minutes and the time in minutes the lasagna has spent in the oven at the moment.

```elm
elapsedTimeInMinutes 3 20
    --> 26
```
