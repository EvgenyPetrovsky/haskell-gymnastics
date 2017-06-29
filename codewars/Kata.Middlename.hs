module Codewars.G964.Getmiddle where

getMiddle :: String -> String
getMiddle "" = ""
getMiddle x = take tn . drop dn $ x
  where 
    lx = length x
    tn = if (even lx) then 2 else 1
    dn = div (lx + 1) 2 - 1
