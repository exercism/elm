module Tests exposing (tests)

import Expect
import LargestSeriesProduct exposing (largestProduct)
import Test exposing (..)


tests : Test
tests =
    describe "largestProduct"
        [ test "can find the largest product of 2 with numbers in order" <|
            \() -> Expect.equal (Just 72) (largestProduct 2 "0123456789")
        , skip <|
            test "can find the largest product of 2" <|
                \() -> Expect.equal (Just 48) (largestProduct 2 "576802143")
        , skip <|
            test "finds the largest product if span equals length" <|
                \() -> Expect.equal (Just 18) (largestProduct 2 "29")
        , skip <|
            test "can find the largest product of 3 with numbers in order" <|
                \() -> Expect.equal (Just 504) (largestProduct 3 "0123456789")
        , skip <|
            test "can find the largest product of 3" <|
                \() -> Expect.equal (Just 270) (largestProduct 3 "1027839564")
        , skip <|
            test "can find the largest product of 5 with numbers in order" <|
                \() -> Expect.equal (Just 15120) (largestProduct 5 "0123456789")
        , skip <|
            test "can get the largest product of a big number" <|
                \() -> Expect.equal (Just 23520) (largestProduct 6 "73167176531330624919225119674426574742355349194934")
        , skip <|
            test "can get the largest product of a big number II" <|
                \() -> Expect.equal (Just 28350) (largestProduct 6 "52677741234314237566414902593461595376319419139427")
        , skip <|
            test "can get the largest product of a big number (Project Euler)" <|
                \() -> Expect.equal (Just 23514624000) (largestProduct 13 "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450")
        , skip <|
            test "reports zero if the only digits are zero" <|
                \() -> Expect.equal (Just 0) (largestProduct 2 "0000")
        , skip <|
            test "reports zero if all spans include zero" <|
                \() -> Expect.equal (Just 0) (largestProduct 3 "99099")
        , skip <|
            test "rejects span longer than string length" <|
                \() -> Expect.equal Nothing (largestProduct 4 "123")
        , skip <|
            test "rejects empty string and nonzero span" <|
                \() -> Expect.equal Nothing (largestProduct 1 "")
        , skip <|
            test "rejects invalid character in digits" <|
                \() -> Expect.equal Nothing (largestProduct 2 "1234a5")
        , skip <|
            test "rejects negative span" <|
                \() -> Expect.equal Nothing (largestProduct -1 "12345")
        ]
