-- https://www.codewars.com/kata/multiples-of-3-and-5/train/haskell
module MultiplesOf3And5 where
  
solution :: Integer -> Integer
solution number = sum [x | x <- [1..number - 1], any (\y -> mod x y ==0) [3,5]]