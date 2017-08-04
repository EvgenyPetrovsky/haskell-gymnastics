-- https://www.codewars.com/kata/integers-recreation-one/train/haskell
module Codewars.G964.Sumdivsq where

listSquared :: Int -> Int -> [(Int, Int)]
listSquared m n = [m..n] >>= (\x -> [x, (divisors x n)]) >>= 

divisors acc n = 
  let 
    (d, r) = n `div` acc
  in
    if if r /= 0 then divisors (acc + 1) n
    else if d < acc then d : acc : divisors (acc + 1) n
    else d : [n]
    
