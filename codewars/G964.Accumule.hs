-- https://www.codewars.com/kata/5667e8f4e3f572a8f2000039/train/haskell

module Codewars.G964.Accumule where

import Data.Char (toLower, toUpper)
import Data.List (intercalate)

accum :: [Char] -> [Char]
accum s =
  intercalate "-" capitalized
  where 
    charTimes = zipWith replicate [1..] $ map toLower s
    capitalized = map (\x -> toUpper (head x) : (tail x)) charTimes