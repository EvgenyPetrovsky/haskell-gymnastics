-- https://www.codewars.com/kata/int32-to-ipv4/train/haskell

module IPv4 where
import Data.Word (Word32)
import Data.List (intercalate)

type IPString = String

int32ToIP :: Word32 -> IPString
int32ToIP n = intercalate "." . fmap show $ [p1, p2, p3, p4]
    where
    (p123, p4) = divMod n 256
    (p12,  p3) = divMod p123  256
    (p1,   p2) = divMod p12   256
