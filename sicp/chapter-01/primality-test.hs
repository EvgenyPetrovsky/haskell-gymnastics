-- O ( sqrt N )
isPrimeSlow :: Integer -> Bool

isPrimeSlow a = 
    iter a 2
    where 
        threshold = toInteger . truncate . sqrt . fromInteger $ a
        iter a v
            | v > threshold = True
            | rem a v == 0  = False 
            | otherwise     = iter a $ v + 1
            
