module Codewars.Kata.Reduction where
--import Codewars.Kata.Reduction.Direction

data Direction = North | East | West | South deriving (Eq, Show)

dirReduce :: [Direction] -> [Direction]
dirReduce path = 
    if optimized == path
        then path
        else dirReduce optimized
    where optimized = optimize path

optimize :: [Direction] -> [Direction]
optimize [] = []
optimize (x1:x2:xs) 
    | (x1,x2) `elem` loops = xs
    | otherwise = x1 : (optimize (x2:xs))
optimize (x:xs) = x : (optimize xs)

loops :: [(Direction, Direction)]
loops = [(North, South), (South, North), (East, West), (West, East)]
