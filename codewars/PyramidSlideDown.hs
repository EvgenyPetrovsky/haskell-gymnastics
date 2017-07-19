-- https://www.codewars.com/kata/551f23362ff852e2ab000037/train/haskell
module PyramidSlideDown where

import Data.List (groupBy, maximumBy)

longestSlideDown :: [[Int]] -> Int
longestSlideDown [] = 0 
longestSlideDown (top:rest) = iterate' rest [[(1::Int, head top)]]

{-
solution description (solution is ugly compared to best on codewars)
introduce task defeinition in terms of programming language: 
  path, 
  level, 
  slideDown (add one step to path)
  select longest of paths across path that finish in the same point
  set of longest paths for each point
  select longest path across all path of level
-}

type Block = Int
type Position = Int
type Layer = [Block]
type Pyramid = [Layer]
type CutPyramid = [Layer]
type Path = [(Position, Block)]
type Paths = [Path]

-- main recursion
iterate' :: CutPyramid -> Paths -> Int
iterate' [] paths = maximum . map pathLength $ paths
iterate' (layer:rest) paths =
  let 
    pathPairs = map (slideDown layer) paths
    allPaths  = foldl1 (++) pathPairs 
  in
    iterate' rest $ shrinkShort allPaths

-- funtion slideDown - generates all possible combinations of path for given path and pyramid
slideDown :: Layer -> Path -> Paths
slideDown layer path@((position, _):_) =
  let 
    (left:right:_) = drop (position-1) $ layer
    lpath = (position, left):path
    rpath = (position+1, right):path
  in
    [lpath, rpath]

-- calculates path length
pathLength :: Path -> Int
pathLength = sum . map snd

-- keeps 1 lonest path for each position for last slide down
shrinkShort :: [Path] -> [Path]
shrinkShort paths = 
  let 
    groupped = groupBy (\x y -> fst (head x) == fst (head y)) paths
    takeMax  = maximumBy (\x y -> pathLength x `compare` pathLength y)
  in
    map takeMax groupped
