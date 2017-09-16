-- https://www.codewars.com/kata/are-they-the-same/train/haskell
module Codewars.Kata.Compare where

import Data.List (sort)

comp :: [Integer] -> [Integer] -> Bool
comp as bs = sort [x*x | x <- as] == sort bs
