# Instructions

You are the new bosun of a small pirate crew that just killed their previous bosun for fowling their merriment with a bad song. As pirates would have it, your crew likes to pass the time getting loaded to the gunwales while crossing the briny deep and you are in charge of rationing the beer. The Cap'n has tasked you to minimize the number of resupply trips to make the best possible time between hauls. To achieve these conflicting requirements, and keep your crew from blowing you down when you are also loaded to the gunwales, you decide to stick to the tried-and-true 99 Bottles of Beer song using a program to help you keep the song straight and remind you to make a beer run when the ship is running low.

## 1. Return the last stanza when there are 0 beers.

Implement a `beerSongFrom` function that returns the last two verses of the beer song, in separate lines, when given the value `0`.

> No more bottles of beer on the wall, no more bottles of beer.</br>
> Go to shore to get some more, 99 bottles of beer on the wall!</br>

## 2. Return the last two stanzas when starting with 1 beer.

Refactor your `beerSongFrom` function to return the second to last stanza of the beer song when given the value `1`, followed by the rest of the song. Make sure your stanzas are properly separated by one empty line!

> 1 bottle of beer on the wall, 1 bottle of beer.</br>
> Take it down and pass it around, no more bottles of beer on the wall.<br><br>...
    
## 3. Return the last three stanzas when starting with 2 beers.

Refactor your `beerSongFrom` function once again to return the third to last stanza when given the value `2`, followed by the rest of the song.
> 2 bottles of beer on the wall, 2 bottles of beer.</br>
> Take one down and pass it around, 1 bottle of beer on the wall.<br><br>...

## 4. Return any number of verses with the correct ending.

Your crew is never satisfied with less than 30 beers, and you realize your poor writing skills are likely to make you foul the song if you try to write every stanza by hand. So, you decide to refactor the function one last time to make it work for any number of beers. You also want the last stanza to change to show the crew's satisfaction when they had at least 30 beers, or remind you it is time to get more beer to keep them happy if you started from less than 30.
> ... <br><br>
> 1 bottle of beer on the wall, 1 bottle of beer.</br>
> Take it down and pass it around, no more bottles of beer on the wall.

Should be followed by either

> No more bottles of beer on the wall, no more bottles of beer.</br>
> Go to the shore to get some more, 99 bottles of beer on the wall!

if they started with less than 30 beers, or

> No more bottles of beer on the wall, no more bottles of beer.</br>
> We've taken them down and passed them around; now we're all drunk and passed out!

if they had 30 beers or more.

## Present your song to the crew!

Now you feel almost ready to present your song to the crew without too much risk of being made to dance the hempen jig. But, as they are a picky bunch, make sure you remove as much duplication as possible, optimize for readability, and try to replace conditionals with `case` statements; then publish your solution. Good luck matey!