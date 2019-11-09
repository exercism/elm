module Tests exposing (tests)

import <exercise> exposing (<function>)
import Expect
import Test exposing (..)


tests : Test
tests =
    describe "<exercise>"
        [ test "foo" <|
            \() -> Expect.equal "foo" "foo"
        , skip <|
            test "bar" <|
                \() -> Expect.equal "foo" "bar"
        ]
