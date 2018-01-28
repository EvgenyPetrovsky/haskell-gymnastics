-- exponentiate using multiplication 
-- O (N)
exp :: Int -> Int -> Int

-- fast exponentiation
-- O (log N)
fastExp :: Int -> Int -> Int

-- multiplication based on addition
mul :: Int -> Int 
mul a b = 
    let
        mul' a b acc = 
            | b == 1 = acc
            | b < 0 = mul' (neg a) (neg b) acc
            | otherwise = mul' a (b-1) (acc + a)
    in
        mul' a b 0
        
