-- https://www.codewars.com/kata/n-centered-array/train/haskell
module Codewars.CenteredArray where
  
isCentered :: [Int] -> Int -> Bool
isCentered xs n
  | length xs == 0 = False
  | n == 0 && length xs `rem` 2 == 0 = True
  | otherwise = isCentered' t (n-h)
  where (h:t) = foldInMid xs

isCentered' :: [Int] -> Int -> Bool
isCentered' _ 0 = True
isCentered' [] _ = False
isCentered' (x:xs) n = isCentered' xs (n-x)

foldInMid xs = 
  | m == 0 = zipWith (+) (reverse l) r
  | otherwise = (head r) : zipWith (+) (reverse l) (tail r)
  where 
    (d,m) = length xs `divMod` 2
    (l,r) = splitAt d xs