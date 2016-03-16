module StrainExample where

import List

keep : (a -> Bool) -> List a ->  List a
keep predicate list = List.filter predicate list

discard : (a -> Bool) -> List a -> List a
discard predicate list = (keep (\val -> not (predicate val)) list)
