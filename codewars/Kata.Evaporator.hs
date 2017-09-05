module Codewars.Kata.Evaporator where
  
evaporator :: Double -> Double -> Double -> Integer
evaporator content evap_per_day threshold = 
  toInteger . ( + 1) .length $ takeWhile ( > threshold / 100) cont_by_days
  where 
    cont_by_days = [ (1-evap_per_day/100)^n | n <- [1..] ]
