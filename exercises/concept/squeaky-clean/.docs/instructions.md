# Instructions

In this exercise you will implement a partial set of utility functions to help a developer clean up identifier names.

In the 5 tasks you will gradually build up the `clean` function.
A valid identifier comprises zero or more letters and underscores.

If an empty string is passed to the `clean` function, an empty string should be returned.

## 1. Replace spaces with underscores

Implement a `clean1` function to replace any spaces with underscores. This also applies to leading and trailing spaces.

```elm
clean1 "my   Id"
    --> "my___Id"
```

## 2. Replace control characters with the upper case string "CTRL"

Implement `clean2` to do everything the previous function does and replace common control characters (\n, \t, and \r ) with the string `"[CTRL]"`.

```elm
clean2 "my\0Id"
    --> "myCTRLId",
```

## 3. Convert kebab-case to camelCase

Implement `clean3` to do everything the previous function does and convert kebab-case to camelCase.

```elm
clean "à-ḃç"
    --> "àḂç"
```

## 4. Omit digits 

Implement 'clean4` to do everything the previous function does and omit all digits.

```elm
clean "123"
    --> ""
```

## 5. Omit Greek lower case letters

Finally, implement `clean` to do everything the previous function does and omit any Greek letters in the range 'α' to 'ω'.

```elm
clean "My Οβιεγτ Finder"
    --> "My_Ο_Finder"
```