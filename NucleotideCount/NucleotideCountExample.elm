module NucleotideCountExample where

import String
import List

nucleotideCounts : String -> List (Char, Int)
nucleotideCounts sequence = [
  (getCount 'A' sequence),
  (getCount 'T' sequence),
  (getCount 'C' sequence),
  (getCount 'G' sequence)
  ]

getCount : Char -> String -> (Char, Int)
getCount base sequence = (base, (List.length (String.split (String.fromChar base) sequence)) - 1)
