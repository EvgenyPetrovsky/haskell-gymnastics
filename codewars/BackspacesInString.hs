-- https://www.codewars.com/kata/backspaces-in-string/train/haskell
module Codewars.BackspacesInString where

cleanString :: String -> String
cleanString = reverse . foldr procChar [] . reverse

procChar :: Char -> String -> String
procChar '#' [] = []
procChar '#' (s:ss) = ss
procChar c ss = c:ss
