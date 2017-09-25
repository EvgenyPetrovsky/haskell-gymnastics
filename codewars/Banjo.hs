-- https://www.codewars.com/kata/are-you-playing-banjo/train/haskell
module Banjo where

import Data.Char (toUpper)
  
areYouPlayingBanjo :: String -> String
areYouPlayingBanjo name
  | fstLtr name == 'R' = name ++ " plays banjo"
  | otherwise = name ++ " does not play banjo"
  where fstLtr = toUpper . head
