module Codewars.G964.WeightSort where

import Data.List (sort)

-- rewrite; translate element into number during sort operation
orderWeight :: [Char] -> [Char]
orderWeight strng = map map show . sortBy sumDigits . map read . sort . words

sumDigits :: Int -> Int
sumDigits 0 = 0
sumDigits x = 
  m + sumDigits d
  where (d, m) = divMod x 10
  --your code

