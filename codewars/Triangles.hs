-- https://www.codewars.com/kata/56606694ec01347ce800001b/train/haskell
module Codewars.Triangles where
    
import Data.List (sort)

isTriangle :: Int -> Int -> Int -> Bool
isTriangle a b c = (s1 + s2) > s3
    where [s1, s2, s3] = sort [a, b, c]