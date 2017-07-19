module Codewars.Kata.Arithmetic 
( findMissing )
where

findMissing :: Integral n => [n] -> n
findMissing ap(x1:x2:xs) = 
    if x + offset == x2
        then findMissing (x2:xs)
        else x + offset
    where offset = find

findOffset :: (Integral n) => [n] -> n
findOffset (x1:x2:x3:_) = sortBy abs [x2-x1, x3-x2]
    if (s1*2) == s2 
        then s1 
        else s2
    where 
        s1 = x2-x1
        s2 = x3-x2
