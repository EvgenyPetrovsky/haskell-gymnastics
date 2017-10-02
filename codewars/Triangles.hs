-- https://www.codewars.com/kata/56606694ec01347ce800001b/train/haskell
module Codewars.Triangles where
    
import Data.List (sort)

isTriangle :: Int -> Int -> Int -> Bool
isTriangle a b c = and [a + b > c, b + c > a, c + a > b]