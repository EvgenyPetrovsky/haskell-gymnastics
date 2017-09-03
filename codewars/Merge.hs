-- https://www.codewars.com/kata/52336a4436e0b095d8000093/train/haskell
module Merge where

merge :: Ord a => [a] -> [a] -> [a]
--merge xs ys = error "todo: merge"
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
    | x <= y = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys