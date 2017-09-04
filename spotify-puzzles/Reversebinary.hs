-- ProblemID: Reversebinary

reverseBinary :: Integral n => n -> n
reverseBinary = (unDigits 2) . reverse . (digits 2)

digits :: Integral n => n -> n -> [n]
digits base num = reverse $ digitsR base num
  where
    digitsR base num
    | num == 0 = []
    | otherwise = r : (digitsR base v)
        where (v,r) = divMod num base

unDigits :: Integral n => n -> [n] -> n
unDigits base num = sum . zipWith (*) baseExp $ reverse num
  where baseExp = [ base^x | x <- [0..]]
