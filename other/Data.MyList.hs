-- function that takes list of values and splits it according to list of chunks
splitInto :: [a] -> [Int] -> [[a]]

splitInto a [] = []
splitInto a (n:ns) = 
  l:(splitInto r ns)
  where (l,r) = splitAt n a