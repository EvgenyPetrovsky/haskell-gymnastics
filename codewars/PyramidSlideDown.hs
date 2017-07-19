-- https://www.codewars.com/kata/551f23362ff852e2ab000037/train/haskell
module PyramidSlideDown where

longestSlideDown :: [[Int]] -> Int
longestSlideDown = undefined
-- TODO: write some code...


--data Direction = Left | Right deriving (Show, Eq)

type Block = Int
type Layer = [Block]
type Pyramid = [Layer]
type CutPyramid = Pyramid
type Level = Int
type Position = Int
type Path = [(Position, Block)]
type AllPaths = [Path]
type LongestPaths = [Path]

-- funtion slideDown - generates all possible combinations of path for given path and pyramid
slideDown :: CutPyramid -> Path -> Paths
slideDown :: [[]] path = path
slideDown :: layer:_ path@((position, _):_) =
  let 
    (left:right:_) = drop position $ layer
    lpath = (position, left):path
    rpath = (position+1, right):path
  in
    [lpath, rpath]

-- calculates path length
pathLength :: Path -> Int
pathLength = sum . map snd

-- keeps 1 lonest path for each position for last slide down
selectLongest :: [Path] -> [Path]
--group by last position >> sort by lenght >> keep 1st longest

{-
solution description
introduce task defeinition in terms of programming language: 
  path, 
  level, 
  slideDown (add one step to path)
  select longest of paths across path that finish in the same point
  set of longest paths for each point
  select longest path across all path of level
-}
