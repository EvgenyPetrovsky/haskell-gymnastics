-- https://www.codewars.com/kata/integers-recreation-one/train/haskell
module Codewars.G964.Sumdivsq where

listSquared :: Int -> Int -> [(Int, Int)]
listSquared m n = filter ( testSqrt . snd ) $ map pair [m..n]
  where 
    pair x = (x, sum . map (\x -> x * x) . divisors $ x)

divisors :: Int -> [Int]
divisors n = [x | x <- [1..n], n `rem` x == 0]

testSqrt :: Int -> Bool
testSqrt x = (intSqrt x * intSqrt x) == x

intSqrt :: Int -> Int
intSqrt x = truncate . sqrt . fromIntegral $ x
