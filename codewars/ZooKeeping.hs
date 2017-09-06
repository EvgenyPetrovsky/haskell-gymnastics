module ZooKeeping where

import Data.List (intercalate)

whoEatsWho :: String -> [String]
whoEatsWho zoo_ff = 
  let 
    inhabitants = splitWhen (==',') zoo_ff
    disasterLog = roundZoo inhabitants []
  in 
    map (joinWith ",") disasterLog

splitWhen :: (a -> Bool) -> [a] -> [[a]]
splitWhen f list = iter list []
  where 
    iter [] acc = (reverse acc) : []
    iter (x:xs) acc 
      | f x = (reverse acc) : (iter xs [])
      | otherwise = iter xs (x:acc)

joinWith :: [a] -> [[a]] -> [a]
joinWith = intercalate

roundZoo :: [String] -> [String] -> [[String]]
roundZoo zoo_ff prev
  | zoo_ff == prev = []
  | otherwise = zoo_ff : (roundZoo (reduce zoo_ff) zoo_ff)

reduce :: [String] -> [String]
reduce (x1:x2:xs)
  | (x2, x1) `elem` diet = x2 : xs
  | (x1, x2) `elem` diet = x1 : xs
  | otherwise = x1 : (reduce $ x2 : xs)
reduce x = x

diet :: [(String, String)]
diet = [
  ("antelope", "grass"),
  ("big-fish", "little-fish"),
  ("bug", "leaves"),
  ("bear", "big-fish"),
  ("bear", "bug"),
  ("bear", "chicken"),
  ("bear", "cow"),
  ("bear", "leaves"),
  ("bear", "sheep"),
  ("chicken", "bug"),
  ("cow", "grass"),
  ("fox", "chicken"),
  ("fox", "sheep"),
  ("giraffe", "leaves"),
  ("lion", "antelope"),
  ("lion", "cow"),
  ("panda", "leaves"),
  ("sheep", "grass") 
  ]