module Main exposing (..)

import ElmTest exposing (..)
import AtbashCipher exposing (encode, decode)


tests : Test
tests =
    suite "AtbashCipher"
        [ test "encode no"
            (assertEqual "ml" (encode "no"))
        , test "encode yes"
            (assertEqual "bvh" (encode "yes"))
        , test "encode OMG"
            (assertEqual "lnt" (encode "OMG"))
        , test "encode O M G"
            (assertEqual "lnt" (encode "O M G"))
        , test "encode long word"
            (assertEqual "nrmwy oldrm tob" (encode "mindblowingly"))
        , test "encode numbers"
            (assertEqual "gvhgr mt123 gvhgr mt" (encode "Testing, 1 2 3, testing."))
        , test "encode sentence"
            (assertEqual "gifgs rhurx grlm" (encode "Truth is fiction."))
        , test "encode all things"
            (assertEqual "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
                (encode "The quick brown fox jumps over the lazy dog.")
            )
        , test "decode word"
            (assertEqual "exercism" (decode "vcvix rhn"))
        , test "decode sentence"
            (assertEqual "anobstacleisoftenasteppingstone"
                (decode "zmlyh gzxov rhlug vmzhg vkkrm thglm v")
            )
        ]


main : Program Never
main =
    runSuite tests
