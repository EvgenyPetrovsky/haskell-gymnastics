module HumanTime where

humanReadable :: Int -> String
humanReadable time = 
    hh++":"++mm++":"++ss
    where 
        ss = fmt $ time `mod` 60
        mm = fmt $ (time `div` 60) `mod` 60
        hh = fmt $ time `div` (60 * 60)

fmt :: Int -> String
fmt = drop 1 . show . (+) 100