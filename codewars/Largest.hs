-- https://www.codewars.com/kata/largest-elements/haskell

module CodeWars.Largest (largest) where

import Data.List (sort)

largest :: Ord a => Int -> [a] -> [a]
largest n xs = reverse . take n . reverse . sort $ xs 