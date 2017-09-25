-- https://www.codewars.com/kata/568d0dd208ee69389d000016/train/haskell
module Codewars.G964.Rentalcarcost where
  
  rentalCarCost :: Int -> Int
  rentalCarCost d = d * 40 - discount
    where discount = if (d >= 7) then 50
                     else if (d >= 3) then 20
                     else 0
