module Codewars.Thinkful.TrafficLights where

updateLight :: String -> String
updateLight l =
  let
    sequence = ["Green", "Yellow", "Red", "Green"]
  in
    head . tail . dropWhile (\x -> x /= l) $ sequence