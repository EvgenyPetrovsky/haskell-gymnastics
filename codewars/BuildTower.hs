module Codewars.BuildTower where

buildTower :: Int -> [String]
buildTower heigth = 
    map fullLn [1..heigth]   
    where
        halfLn level = replicate level '*' ++ replicate (heigth - level) ' '
        fullLn level = (reverse . tail . halfLn $ level) ++ halfLn level
