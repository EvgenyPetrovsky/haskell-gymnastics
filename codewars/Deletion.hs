-- https://www.codewars.com/kata/delete-occurrences-of-an-element-if-it-occurs-more-than-n-times/train/haskell
module Codewars.Kata.Deletion where

import Data.Map (Map, unionWith, singleton, empty, (!))
deleteNth :: [Int] -> Int -> [Int]
deleteNth lst n = iter lst n empty

iter :: [Int] -> Int -> Map Int Int -> [Int]
iter [] _ _ = []
iter (p:ps) lim acm
  | reg ! p > lim = iter ps lim reg
  | otherwise = (:) p $ iter ps lim reg
  where 
    reg = inc p acm

inc :: Int -> Map Int Int -> Map Int Int
inc k m = unionWith (+) m (singleton k 1)