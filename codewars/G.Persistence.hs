module Codewars.G.Persistence where

persistence :: Int -> Int
persistence n = iter 0 $ show n
    
iter :: Int -> String -> Int
iter i (_:"") = i
iter i s = 
    iter (i + 1) $ show . product . digitList $ s

digitList :: String -> [Int]
digitList = map (\x -> read  (x:[]) :: Int)
