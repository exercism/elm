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
      "name": "Otto Doge",
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
  }
]
```

Of course, the frontend will be done in Elm, but first you need to figure out what those decoders/encoders are all about.

```exercism/note
Humorous story aside, the exercise requirements were taken directly from GitHub's REST API endpoints for pull request review comments.
We removed some fields from the JSON schemas for the sake of simplicity, but this is as close to real-world applications as it gets.
```

## 1. ID, please!

## 2. What's my name again?

## 3. User? I hardly know her!

## 4. I'm a strong independent comment

## 5. Side hustle

## 6. Links awakening

## 7. Yes comments

## 8. Back to square one
