-- https://www.codewars.com/kata/integers-recreation-one/train/haskell
module Codewars.G964.Sumdivsq where

listSquared :: Int -> Int -> [(Int, Int)]
listSquared m n = filter ( testSqrt . snd ) $ map pair [m..n]
  where 
    pair x = (x, sum . divisors $ x)

divisors :: Int -> [Int]
divisors n = filter (\x -> n `mod` x == 0) [1..n]

testSqrt :: Int -> Bool
testSqrt x = (intSqrt x * intSqrt x) == x

intSqrt :: Int -> Int
intSqrt x = truncate . sqrt . fromIntegral $ x
