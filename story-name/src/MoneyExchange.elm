module MoneyExchange exposing (..)


type Currency a b
    = Local a
    | Reference b

eitherCurrency : (a -> c) -> (b -> c) -> Currency a b -> c
eitherCurrency f g value =
  case value of
    Local a -> f a
    Reference b -> g b

keepFirst : a -> b -> a
keepFirst a _ = a

replaceLocal : c -> Currency a b -> Currency c b
replaceLocal c = eitherCurrency (keepFirst c >> Local) Reference

mapReference : (b -> c) -> Currency a b -> Currency a c
mapReference f = eitherCurrency Local (f >> Reference)

 
-- Know how to use phantom types.

type Euro = Euro
type Yen = Yen

type Money currency = Money Int


addCurrency : Money currency -> Money currency -> Money currency
addCurrency (Money a) (Money b) = Money (a + b)

convert : (Int -> Int) -> Money currencyA -> Money currencyB
convert rate (Money a) = Money (rate a)

euroToYen : Money Euro -> Money   Yen
euroToYen = convert ((*) 130)
