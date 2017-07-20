-- https://projecteuler.net/problem=1

sumMul35 :: Int -> Int
sumMul35 n = 
    let
        f x = (mod x 3 == 0) || (mod x 5 == 0)
    in
        sum . filer f $ [1..n]

solution1 = sumMul35 $ 1000 - 1
