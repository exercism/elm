module Tests exposing (tests)

import Dict
import Expect
import GithupApi exposing (Side(..))
import Json.Decode as Decode
import Json.Encode as Encode
import Test exposing (Test, describe, test)


tests : Test
tests =
    describe "GithupApi"
        [ describe "1"
            [ test "decodeId for valid JSON" <|
                \() ->
                    """{"id": 10}"""
                        |> Decode.decodeString GithupApi.decodeId
                        |> Expect.equal (Ok 10)
            , test "decodeId for JSON with unexpected key" <|
                \() ->
                    """{"not_id": 10}"""
                        |> Decode.decodeString GithupApi.decodeId
                        |> Expect.err
            , test "decodeId for JSON with unexpected value" <|
                \() ->
                    """{"id": "10"}"""
                        |> Decode.decodeString GithupApi.decodeId
                        |> Expect.err
            ]
        , describe "2"
            [ test "decodeName for JSON with a name" <|
                \() ->
                    """{"id": 10, "name": "Otto"}"""
                        |> Decode.decodeString GithupApi.decodeName
                        |> Expect.equal (Ok (Just "Otto"))
            , test "decodeName for JSON without name" <|
                \() ->
                    """{"id": 10}"""
                        |> Decode.decodeString GithupApi.decodeName
                        |> Expect.equal (Ok Nothing)
            ]
        , describe "3"
            [ test "decodeUser for valid JSON with a name" <|
                \() ->
                    """
                    {
                      "id": 1,
                      "login": "octodog",
                      "name": "Otto Doge",
                      "avatar_url": "https://githup.com/images/error/octodog_happy.gif",
                      "site_admin": false
                    }
                    """
                        |> Decode.decodeString GithupApi.decodeUser
                        |> Expect.equal
                            (Ok
                                { id = 1
                                , login = "octodog"
                                , name = Just "Otto Doge"
                                , avatarUrl = "https://githup.com/images/error/octodog_happy.gif"
                                , siteAdmin = False
                                }
                            )
            , test "decodeUser for JSON without name" <|
                \() ->
                    """
                    {
                      "id": 1,
                      "login": "octodog",
                      "avatar_url": "https://githup.com/images/error/octodog_happy.gif",
                      "site_admin": false
                    }
                    """
                        |> Decode.decodeString GithupApi.decodeUser
                        |> Expect.equal
                            (Ok
                                { id = 1
                                , login = "octodog"
                                , name = Nothing
                                , avatarUrl = "https://githup.com/images/error/octodog_happy.gif"
                                , siteAdmin = False
                                }
                            )
            , test "decodeUser for JSON without avatar_url" <|
                \() ->
                    """
                    {
                      "id": 1,
                      "login": "octodog",
                      "site_admin": false
                    }
                    """
                        |> Decode.decodeString GithupApi.decodeUser
                        |> Expect.err
            ]
        , describe "4"
            [ test "decodePullRequestReviewId for JSON with an id" <|
                \() ->
                    """{"pull_request_review_id": 11}"""
                        |> Decode.decodeString GithupApi.decodePullRequestReviewId
                        |> Expect.equal (Ok (Just 11))
            , test "decodePullRequestReviewId for JSON with a null" <|
                \() ->
                    """{"pull_request_review_id": null}"""
                        |> Decode.decodeString GithupApi.decodePullRequestReviewId
                        |> Expect.equal (Ok Nothing)
            , test "decodePullRequestReviewId for JSON with an unexpected value" <|
                \() ->
                    """{"pull_request_review_id": "154A564BF"}"""
                        |> Decode.decodeString GithupApi.decodePullRequestReviewId
                        |> Expect.err
            , test "decodePullRequestReviewId for JSON with missing field" <|
                \() ->
                    """{"id": "10"}"""
                        |> Decode.decodeString GithupApi.decodePullRequestReviewId
                        |> Expect.err
            ]
        , describe "5"
            [ test "decodeSide for JSON with LEFT" <|
                \() ->
                    """{"side": "LEFT"}"""
                        |> Decode.decodeString GithupApi.decodeSide
                        |> Expect.equal (Ok Left)
            , test "decodeSide for JSON with RIGHT" <|
                \() ->
                    """{"side": "RIGHT"}"""
                        |> Decode.decodeString GithupApi.decodeSide
                        |> Expect.equal (Ok Right)
            , test "decodeSide for JSON with unexpected value" <|
                \() ->
                    """{"side": "154A564BF"}"""
                        |> Decode.decodeString GithupApi.decodeSide
                        |> Expect.err
            , test "decodeSide for JSON with unexpected key" <|
                \() ->
                    """{"side_start": "RIGHT"}"""
                        |> Decode.decodeString GithupApi.decodeSide
                        |> Expect.err
            ]
        , describe "6"
            [ test "decodeLinks for valid JSON without links" <|
                \() ->
                    """{ "_links": {}}"""
                        |> Decode.decodeString GithupApi.decodeLinks
                        |> Expect.equal (Ok Dict.empty)
            , test "decodeLinks for valid JSON with links" <|
                \() ->
                    """
                    {
                      "_links": {
                        "self": {
                          "href": "https://api.githup.com/repos/octodog/Hello-World/pulls/comments/1"
                        },
                        "html": {
                          "href": "https://githup.com/octodog/Hello-World/pull/1#discussion-diff-1"
                        },
                        "some_never_seen_before_key": {
                          "href": "https://api.githup.com/repos/octodog/Hello-World/pulls/1"
                        }
                      }
                    }
                    """
                        |> Decode.decodeString GithupApi.decodeLinks
                        |> Expect.equal
                            (Ok
                                (Dict.fromList
                                    [ ( "self", "https://api.githup.com/repos/octodog/Hello-World/pulls/comments/1" )
                                    , ( "html", "https://githup.com/octodog/Hello-World/pull/1#discussion-diff-1" )
                                    , ( "some_never_seen_before_key", "https://api.githup.com/repos/octodog/Hello-World/pulls/1" )
                                    ]
                                )
                            )
            , test "decodeLinks for JSON with unexpected key" <|
                \() ->
                    """
                    {
                      "_links": {
                        "self": {
                          "url": "https://api.githup.com/repos/octodog/Hello-World/pulls/comments/1"
                      }
                    }
                    """
                        |> Decode.decodeString GithupApi.decodeLinks
                        |> Expect.err
            , test "decodeLinks for JSON with missing field" <|
                \() ->
                    """{"id": "10"}"""
                        |> Decode.decodeString GithupApi.decodeLinks
                        |> Expect.err
            ]
        , describe "7"
            [ test "decodeComment for valid JSON" <|
                \() ->
                    """
                    {
                      "id": 10,
                      "pull_request_review_id": 42,
                      "user": {
                        "id": 1,
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
                    }
                    """
                        |> Decode.decodeString GithupApi.decodeComment
                        |> Expect.equal
                            (Ok
                                { id = 10
                                , pullRequestReviewId = Just 42
                                , user =
                                    { id = 1
                                    , login = "octodog"
                                    , name = Nothing
                                    , avatarUrl = "https://githup.com/images/error/octodog_happy.gif"
                                    , siteAdmin = False
                                    }
                                , body = "Great stuff!"
                                , side = Right
                                , links =
                                    Dict.fromList
                                        [ ( "self", "https://api.githup.com/repos/octodog/Hello-World/pulls/comments/1" )
                                        , ( "html", "https://githup.com/octodog/Hello-World/pull/1#discussion-diff-1" )
                                        , ( "pull_request", "https://api.githup.com/repos/octodog/Hello-World/pulls/1" )
                                        ]
                                }
                            )
            , test "decodeComments for valid JSON" <|
                \() ->
                    """
                    [
                      {
                          "id": 9,
                          "pull_request_review_id": 42,
                          "user": {
                            "id": 1,
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
                      },
                      {
                        "id": 11,
                        "pull_request_review_id": null,
                        "user": {
                          "id": 2,
                          "login": "hexacat",
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
                    """
                        |> Decode.decodeString GithupApi.decodeComments
                        |> Expect.equal
                            (Ok
                                [ { id = 9
                                  , pullRequestReviewId = Just 42
                                  , user =
                                        { id = 1
                                        , login = "octodog"
                                        , name = Just "Otto Doge"
                                        , avatarUrl = "https://githup.com/images/error/octodog_happy.gif"
                                        , siteAdmin = False
                                        }
                                  , body = "Great stuff!"
                                  , side = Right
                                  , links =
                                        Dict.fromList
                                            [ ( "self", "https://api.githup.com/repos/octodog/Hello-World/pulls/comments/1" )
                                            , ( "html", "https://githup.com/octodog/Hello-World/pull/1#discussion-diff-1" )
                                            , ( "pull_request", "https://api.githup.com/repos/octodog/Hello-World/pulls/1" )
                                            ]
                                  }
                                , { id = 11
                                  , pullRequestReviewId = Nothing
                                  , user =
                                        { id = 2
                                        , login = "hexacat"
                                        , name = Nothing
                                        , avatarUrl = "https://githup.com/images/error/hexacat_happy.gif"
                                        , siteAdmin = True
                                        }
                                  , body = "Amazing stuff!"
                                  , side = Left
                                  , links =
                                        Dict.fromList
                                            [ ( "self", "https://api.githup.com/repos/octodog/Hello-World/pulls/comments/1" ) ]
                                  }
                                ]
                            )
            ]
        , describe "8"
            [ test "encodeComment can encode a comment that decodeComment can decode" <|
                \() ->
                    let
                        comment =
                            { id = 10
                            , pullRequestReviewId = Just 42
                            , user =
                                { id = 1
                                , login = "octodog"
                                , name = Just "Otto Doge"
                                , avatarUrl = "https://githup.com/images/error/octodog_happy.gif"
                                , siteAdmin = False
                                }
                            , body = "Great stuff!"
                            , side = Right
                            , links =
                                Dict.fromList
                                    [ ( "self", "https://api.githup.com/repos/octodog/Hello-World/pulls/comments/1" )
                                    , ( "html", "https://githup.com/octodog/Hello-World/pull/1#discussion-diff-1" )
                                    , ( "pull_request", "https://api.githup.com/repos/octodog/Hello-World/pulls/1" )
                                    ]
                            }
                    in
                    comment
                        |> GithupApi.encodeComment
                        |> Encode.encode 0
                        |> Decode.decodeString GithupApi.decodeComment
                        |> Expect.equal (Ok comment)
            , test "encodeComment can encode comment without optional fields that decodeComment can decode" <|
                \() ->
                    let
                        comment =
                            { id = 11
                            , pullRequestReviewId = Nothing
                            , user =
                                { id = 2
                                , login = "hexacat"
                                , name = Nothing
                                , avatarUrl = "https://githup.com/images/error/hexacat_happy.gif"
                                , siteAdmin = True
                                }
                            , body = ""
                            , side = Left
                            , links = Dict.empty
                            }
                    in
                    comment
                        |> GithupApi.encodeComment
                        |> Encode.encode 0
                        |> Decode.decodeString GithupApi.decodeComment
                        |> Expect.equal (Ok comment)
            ]
        ]
