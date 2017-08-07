-- https://www.codewars.com/kata/are-we-alternate/train/haskell

module Kata.AreWeAlternate (isAlt) where

isAlt :: String -> Bool
isAlt word = 
        and . zipWith (/=) vwBools $ tail vwBools
    where 
        vwBools = map (`elem` "aeiouAEIOU") word
