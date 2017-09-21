-- https://www.codewars.com/kata/n-centered-array/train/haskell
module Codewars.CenteredArray where
  
isCentered :: [Int] -> Int -> Bool
isCentered xs n = elem n $ scanl (+) 0 (foldAtMid xs)

foldAtMid :: [Int] -> [Int]
foldAtMid xs = reverse $ zipWith (+) (reverse r) (l++[0])
  where
    d = length xs `div` 2
    (l,r) = splitAt d xs
