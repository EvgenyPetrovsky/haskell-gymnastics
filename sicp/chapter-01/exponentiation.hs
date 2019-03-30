-- exponentiate using multiplication 
-- O (N)
exp' :: Int -> Int -> Int
exp' b p
  | p == 0 = 1
  | p == 1 = b
  | p <  0 = error "Negative power"
  | otherwise =  b * ( exp' b (p - 1) )

-- fast exponentiation
-- O (log N)
fastExp :: Int -> Int -> Int
fastExp a b = fastExp' a b 1
  where 
    fastExp' a b acc
      | b == 1    = a * acc
      | even b    = fastExp' (a * a) (b `div` 2) acc
      | otherwise = fastExp' (a * a) (b `div` 2) (acc * a)

-- multiplication based on addition
mul' :: Int -> Int -> Int
mul' a b = 
  let
    mul'' a b acc
      | b == 0    = 0
      | b == 1    = a + acc
      | b < 0     = mul'' (negate a) (negate b) acc
      | otherwise = mul'' a (b-1) (acc + a)
  in
    mul'' a b 0
        
