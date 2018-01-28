gcd' :: Int -> Int -> Int

gcd' a b
  | rem_ab == 0 = b
  | otherwise   = gcd' b rem_ab
  where rem_ab = rem a b