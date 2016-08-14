port module Main exposing (..)

import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import AtbashCipher exposing (encode, decode)


tests : Test
tests =
    describe "AtbashCipher"
        [ test "encode no"
            (\() -> Expect.equal "ml" (encode "no"))
        , test "encode yes"
            (\() -> Expect.equal "bvh" (encode "yes"))
        , test "encode OMG"
            (\() -> Expect.equal "lnt" (encode "OMG"))
        , test "encode O M G"
            (\() -> Expect.equal "lnt" (encode "O M G"))
        , test "encode long word"
            (\() -> Expect.equal "nrmwy oldrm tob" (encode "mindblowingly"))
        , test "encode numbers"
            (\() -> Expect.equal "gvhgr mt123 gvhgr mt" (encode "Testing, 1 2 3, testing."))
        , test "encode sentence"
            (\() -> Expect.equal "gifgs rhurx grlm" (encode "Truth is fiction."))
        , test "encode all things"
            (\() ->
                Expect.equal "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
                    (encode "The quick brown fox jumps over the lazy dog.")
            )
        , test "decode word"
            (\() -> Expect.equal "exercism" (decode "vcvix rhn"))
        , test "decode sentence"
            (\() ->
                Expect.equal "anobstacleisoftenasteppingstone"
                    (decode "zmlyh gzxov rhlug vmzhg vkkrm thglm v")
            )
        ]


main : Program Never
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
