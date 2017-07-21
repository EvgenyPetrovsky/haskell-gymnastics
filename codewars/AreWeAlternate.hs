-- https://www.codewars.com/kata/are-we-alternate/train/haskell

module Kata.AreWeAlternate (isAlt) where

isAlt :: String -> Bool
isAlt word = 
        and . zipWith (/=) vowels $ tail vowels
    where 
        vowels = map (`elem` "aeiouAEIOU") word
