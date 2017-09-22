-- https://www.codewars.com/kata/55e2adece53b4cdcb900006c/train/haskell
module Codewars.G964.Tortoise where

race :: Int -> Int -> Int -> Maybe (Int, Int, Int)
race v1 v2 g
  | v2 > v1 = Just (h, m, s)
  | otherwise = Nothing
  where
    x = g * 3600 `div` (v2 - v1)
    (h,r) = x `divMod` 3600
    (m,s) = r `divMod` 60
