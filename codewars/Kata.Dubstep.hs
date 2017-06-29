module Codewars.Kata.Dubstep where

import Data.List.Split

songDecoder :: String -> String
songDecoder songText = 
  unwords . filter (/= "") $ list
  where
    list = splitOn "WUB" songText