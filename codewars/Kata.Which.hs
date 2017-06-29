module Codewars.Kata.Which where

import Data.List (isInfixOf,sort)
import Data.Set (fromList,toList)

inArray :: [String] -> [String] -> [String]
inArray subs strs = toList . fromList . sort $ filter (`testInfix` strs) subs

testInfix :: String -> [String] -> Bool
testInfix sub = any (sub `isInfixOf`)
