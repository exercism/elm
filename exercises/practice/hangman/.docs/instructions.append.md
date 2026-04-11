# Instructions Append

Historically, Elm was using functional reactive programming until it specialized to using the Elm Architecture.

Solve this exercise as if you were writing a web app using the Elm Architecture.
The output of the program should be HTML with the following structure

```html
<div>
  <dl>
    <dt>State</dt>
    <dd>Ongoing</dd>
    <dt>Word</dt>
    <dd>______</dd>
    <dt>Remaining failures</dt>
    <dd>5</dd>
  </dl>
</div>
```

where `<dl>` is the description list element, `<dt>` the description term element and `<dd>` the description details element, all standard HTML elements.

If there is an error, the output should have the following structure

```html
<div>
  <p>error message</p>
</div>
```
