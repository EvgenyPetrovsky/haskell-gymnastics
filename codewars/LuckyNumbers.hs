-- https://www.codewars.com/kata/find-the-lucky-numbers/train/haskell

module Haskell.Codewars.LuckyNumbers where

filterLucky :: [Int] -> [Int]
filterLucky = filter (elem '7' . show)
