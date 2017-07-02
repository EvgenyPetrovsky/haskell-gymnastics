module CreatePhoneNumber where

createPhoneNumber :: [Int] -> String
createPhoneNumber ints = "("++p1++") "++p2++"-"++p3
    where 
        digits = ints >>= show
        (p1, p23) = splitAt 3 digits
        (p2, p3)  = splitAt 3 p23 
