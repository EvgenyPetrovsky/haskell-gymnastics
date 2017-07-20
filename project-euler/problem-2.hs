type FibSequence = [Int]
type Length = Int
-- sequence
fs :: FibSequence
fs = addElem [2,1]

addElem :: FibSequence -> FibSequence
addElem s@(f1:f2:_) 
  | f1 + f2 <= 4000000 = addElem $ (f1 + f2) : s
  | otherwise = s

solution :: Int
solution = sum . filter even $ fs