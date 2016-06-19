module Main exposing (..)

import ElmTest exposing (..)
import LargestSeriesProduct exposing (largestProduct)


tests : Test
tests =
    suite "largestProduct"
        [ test "can find the largest product of 2 with numbers in order"
            (assertEqual (Just 72) (largestProduct 2 "0123456789"))
        , test "can find the largest product of 2"
            (assertEqual (Just 48) (largestProduct 2 "576802143"))
        , test "finds the largest product if span equals length"
            (assertEqual (Just 18) (largestProduct 2 "29"))
        , test "can find the largest product of 3 with numbers in order"
            (assertEqual (Just 504) (largestProduct 3 "0123456789"))
        , test "can find the largest product of 3"
            (assertEqual (Just 270) (largestProduct 3 "1027839564"))
        , test "can find the largest product of 5 with numbers in order"
            (assertEqual (Just 15120) (largestProduct 5 "0123456789"))
        , test "can get the largest product of a big number"
            (assertEqual (Just 23520) (largestProduct 6 "73167176531330624919225119674426574742355349194934"))
        , test "can get the largest product of a big number II"
            (assertEqual (Just 28350) (largestProduct 6 "52677741234314237566414902593461595376319419139427"))
        , test "can get the largest product of a big number (Project Euler)"
            (assertEqual (Just 23514624000) (largestProduct 13 "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450"))
        , test "reports zero if the only digits are zero"
            (assertEqual (Just 0) (largestProduct 2 "0000"))
        , test "reports zero if all spans include zero"
            (assertEqual (Just 0) (largestProduct 3 "99099"))
        , test "rejects span longer than string length"
            (assertEqual Nothing (largestProduct 4 "123"))
        , test "reports 1 for empty string and empty product (0 span)"
            (assertEqual (Just 1) (largestProduct 0 ""))
        , test "reports 1 for nonempty string and empty product (0 span)"
            (assertEqual (Just 1) (largestProduct 0 "123"))
        , test "rejects empty string and nonzero span"
            (assertEqual Nothing (largestProduct 1 ""))
        , test "rejects invalid character in digits"
            (assertEqual Nothing (largestProduct 2 "1234a5"))
        , test "rejects negative span"
            (assertEqual Nothing (largestProduct -1 "12345"))
        ]


main : Program Never
main =
    runSuite tests
