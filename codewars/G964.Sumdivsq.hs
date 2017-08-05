-- https://www.codewars.com/kata/integers-recreation-one/train/haskell
module Codewars.G964.Sumdivsq where

listSquared :: Int -> Int -> [(Int, Int)]
listSquared m n = filter (\ x -> testSqrt (snd x)) $ map pair [m..n]
  --filter (\x -> testsqrt . snd $ x) $ map (sum . pair) [m..n]
  where 
    pair x = (x, sum . divisors $ x)
    testSqrt x = (intSqrt x) * (intSqrt x) == x
    intSqrt x = truncate . sqrt $ x

divisors :: Int -> [Int]
divisors n = filter (\x -> n `mod` x == 0) [1..n]