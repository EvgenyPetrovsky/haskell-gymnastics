-- http://www.codewars.com/kata/5839c48f0cf94640a20001d3/train/haskell

module Kata (landPerimeter) where
import Data.List (transpose)

landPerimeter :: [String] -> String
landPerimeter arr = "Total land perimeter: " ++ show val
    where
        val = 4 * units arr - 
              2 * neibors arr - 
              2 * neibors tra
        tra = transpose arr

units :: [String] -> Int
units arr = sum . map count1 $ arr
    where count1 = length . filter (== 'X')

neibors :: [String] -> Int
neibors arr= sum . map countN $ arr
    where
        countN ln@('X':'X':_) = 1 + (countN . tail $ ln)
        countN [] = 0
        countN (_:xs) = 0 + countN xs
