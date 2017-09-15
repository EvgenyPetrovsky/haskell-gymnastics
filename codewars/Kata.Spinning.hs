module Codewars.Kata.Spinning where

spinWords :: String -> String
spinWords str = unwords . map reverseLong . words $ str
  where 
    reverseLong x
      | length(x) >=5 = reverse x
      | otherwise = x
