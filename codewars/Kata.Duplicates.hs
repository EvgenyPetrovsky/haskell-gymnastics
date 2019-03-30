module Codewars.Kata.Duplicates where

import Data.Char
import Data.List
 
duplicateCount :: String -> Int
duplicateCount = 
    length . filter (\x -> 1 < length x) . group . sort . map toUpper
