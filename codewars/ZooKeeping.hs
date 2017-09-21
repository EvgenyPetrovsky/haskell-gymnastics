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
  | (x2 ++ " eats " ++ x1) `elem` diet = x2 : xs
  | (x1 ++ " eats " ++ x2) `elem` diet = x1 : xs
  | otherwise = x1 : (reduce $ x2 : xs)
reduce x = x

diet :: [String]
diet = [
  "antelope eats grass",
  "big-fish eats little-fish",
  "bug eats leaves",
  "bear eats big-fish",
  "bear eats bug",
  "bear eats chicken",
  "bear eats cow",
  "bear eats leaves",
  "bear eats sheep",
  "chicken eats bug",
  "cow eats grass",
  "fox eats chicken",
  "fox eats sheep",
  "giraffe eats leaves",
  "lion eats antelope",
  "lion eats cow",
  "panda eats leaves",
  "sheep eats grass"
  ]