gcd' :: Int -> Int -> Int

gcd' a b
  | b == 0    = a
  | otherwise = gcd' b (rem a b)