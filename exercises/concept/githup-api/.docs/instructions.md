# Instructions

The more you learn about programming, the more you start thinking that this might be more than just a fad.
There might even be some business opportunities: people write code, they want to save it, share it, collaborate, maybe get some feedback even.

Alright, let's do it, let's build a service to encourage people to code: hup, hup, people, start using git!
Let's call it... GitHup.

You get started on building a REST JSON API: users, pull requests, comments, the backend is swiftly done.
Here is a example of the payload being served when you ask the server for the list of comments on a pull request:

```json
[
  {
    "id": 256,
    "pull_request_review_id": 42,
    "user": {
      "id": 101,
      "login": "octodog",
      "avatar_url": "https://githup.com/images/error/octodog_happy.gif",
      "site_admin": false
    },
    "body": "Great stuff!",
    "side": "RIGHT",
    "_links": {
      "self": {
        "href": "https://api.githup.com/repos/octodog/Hello-World/pulls/comments/1"
      },
      "html": {
        "href": "https://githup.com/octodog/Hello-World/pull/1#discussion-diff-1"
      },
      "pull_request": {
        "href": "https://api.githup.com/repos/octodog/Hello-World/pulls/1"
      }
    }
  },
  {
    "id": 11,
    "pull_request_review_id": null,
    "user": {
      "id": 2,
      "login": "hexacat",
      "name": "Alex Kate",
      "avatar_url": "https://githup.com/images/error/hexacat_happy.gif",
      "site_admin": true
    },
    "body": "Amazing stuff!",
    "side": "LEFT",
    "_links": {
      "self": {
        "href": "https://api.githup.com/repos/octodog/Hello-World/pulls/comments/1"
      }
    }
  }
]
```

Of course, the frontend will be done in Elm, but first you need to figure out what those notorious decoders/encoders are all about.

```exercism/note
Humorous story aside, the exercise requirements are taken directly from GitHub's REST API endpoints for pull request review comments.
Some field were removed from the JSON schemas for the sake of simplicity, but this is as close to real-world applications as it gets.
```

## 1. ID, please!

Your eagle eye has noticed that both comments and users have an `id` field, perfect place to start.

Define `decodeId` so that it can decode a JSON object, with an integer `id`.

```elm
Decode.decodeString decodeId """{id: 10}"""
    --> Ok 10
```

## 2. What's my name again?

You notice in the example above that not all users have a name.

Define `decodeName` so that it can decode a string in the `name` field if there is one.
No name? No problem, simply return `Nothing`.
This decoder should never fail.

```elm
Decode.decodeString decodeName """{"id": 10, "name": "Otto"}"""
    --> Ok (Just Otto)

Decode.decodeString decodeName """null"""
    --> Ok Nothing
```

## 3. User? I hardly know her!

We are pretty much halfway there for decoding users, let's get it done.

Define `decodeUser` so that it can decode a JSON user object.
Make sure to use `decodeId` and `decodeName` in `decodeUser`.

```elm
Decode.decodeString decodeUser
    """
    {
      "id": 101,
      "login": "octodog",
      "avatar_url": "https://githup.com/images/error/octodog_happy.gif",
      "site_admin": false
    }
    """
    --> Ok
    -->   { id = 101
    -->   , name = Nothing
    -->   , login = "octodog"
    -->   , avatarUrl = "https://githup.com/images/error/octodog_happy.gif
    -->   , siteAdmin = False
    -->   }
```

## 4. I'm a strong independent comment

Some comments in a pull review are standalone, and therefore do not have a `pull_request_review_id`.
However, the specification mention that in such a case, there should still be a `pull_request_review_id` field, but the value should be `null`, the poor man's `Nothing`.

Define `decodePullRequestReviewId` so that it can decode an integer in the `pull_request_review_id` field if there is one.
If there is no integer, there should be a `null`, if there is no `null` the decoder should fail.

```elm
Decode.decodeString decodePullRequestReviewId """{"pull_request_review_id": 3}"""
    --> Ok (Just 3)

Decode.decodeString decodePullRequestReviewId """{"pull_request_review_id": null}"""
    --> Ok Nothing

Decode.decodeString decodePullRequestReviewId """{"id": 3}"""
    --> Err ...
```

## 5. Side hustle

Next is this interesting looking `side` field.
In a pull review, you can comment on code that was removed (on the `Left` side of the screen) or on code that was added (on the `Right` side of the screen).

Define `decodeSide` so that it can decode either `"LEFT"` or `"RIGHT"` in the `side` field and match it to its corresponding type variant.

```elm
Decode.decodeString decodeSide """{"side": "LEFT"}"""
    --> Ok Left

Decode.decodeString decodeSide """{"side": "middle?"}"""
    --> Err ...
```

## 6. Links awakening

Each comment has a set of links, which doesn't seem to be consistent across comments.

Define `decodeLinks` so that it can decode a collection of URLs in the `_links` field.
The names and number of links can vary, make sure you can account for that.
The links themselves are JSON objects that should always have a `href` field.

```elm
Decode.decodeString decodeLinks """
    {
      "_links": {
        "self": { "href": "https://api.githup.com/repos/octodog/Hello-World/pulls/comments/1" },
        "html": { "href": "https://githup.com/octodog/Hello-World/pull/1#discussion-diff-1" },
        "pull_request": { "href": "https://api.githup.com/repos/octodog/Hello-World/pulls/1" }
      }
    }
    """
    --> Ok
    -->   (Dict.fromList
    -->       [ ( "self", "https://api.githup.com/repos/octodog/Hello-World/pulls/comments/1" )
    -->       , ( "html", "https://githup.com/octodog/Hello-World/pull/1#discussion-diff-1" )
    -->       , ( "pull_request", "https://api.githup.com/repos/octodog/Hello-World/pulls/1" )
    -->       ]
    -->   )
```

## 7. Yes comments

Almost there, let's get it done.

Define `decodeComment` and `decodeComments` so that they can decode a single JSON comment object or a list of comments respectively.
Make sure to use all of the functions defined so far in `decodeComment`, with the exception of `decodeName`.
Of course, `decodeComments` should use `decodeComment` as well.

## 8. It all ties together

There is one more feature missing in all of this: being able to send a new comment to the server.
For this, you need achieve the opposite of a decoder, you need to be able to transform an Elm `Comment` into a JSON `Value`.

Define `encodeComment` so that it can encode any valid `Comment`.
The order of the fields doesn't matter, as long as the encoder can produce a value that `decodeComment` can decode.
