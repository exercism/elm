module Tests exposing (..)

import Test exposing (..)
import Expect
import AtbashCipher exposing (encode, decode)


tests : Test
tests =
    describe "AtbashCipher"
        [ test "encode no" <|
            \() -> Expect.equal "ml" (encode "no")
        , skip <|
            test "encode yes" <|
                \() -> Expect.equal "bvh" (encode "yes")
        , skip <|
            test "encode OMG" <|
                \() -> Expect.equal "lnt" (encode "OMG")
        , skip <|
            test "encode O M G" <|
                \() -> Expect.equal "lnt" (encode "O M G")
        , skip <|
            test "encode long word" <|
                \() -> Expect.equal "nrmwy oldrm tob" (encode "mindblowingly")
        , skip <|
            test "encode numbers" <|
                \() -> Expect.equal "gvhgr mt123 gvhgr mt" (encode "Testing, 1 2 3, testing.")
        , skip <|
            test "encode sentence" <|
                \() -> Expect.equal "gifgs rhurx grlm" (encode "Truth is fiction.")
        , skip <|
            test "encode all things" <|
                \() ->
                    Expect.equal "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
                        (encode "The quick brown fox jumps over the lazy dog.")
        , skip <|
            test "decode word" <|
                \() -> Expect.equal "exercism" (decode "vcvix rhn")
        , skip <|
            test "decode sentence" <|
                \() ->
                    Expect.equal "anobstacleisoftenasteppingstone"
                        (decode "zmlyh gzxov rhlug vmzhg vkkrm thglm v")
        ]
