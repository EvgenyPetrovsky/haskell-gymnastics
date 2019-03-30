-- https://www.codewars.com/kata/5922543bf9c15705d0000020/train/haskell

module ISO where
<<<<<<< HEAD
  
=======

>>>>>>> 5763d9c1389377b383a7ff51c0f3add6748f57c2
import Data.Void
-- A type of `Void` have no value.
-- So it is impossible to construct `Void`,
-- unless using undefined, error, unsafeCoerce, infinite recursion, etc
-- And there is a function
-- absurd :: Void -> a
-- That get any value out of `Void`
-- We can do this becuase we can never have void in the zeroth place.

-- so, when are two type, `a` and `b`, considered equal?
-- a definition might be, it is possible to go from `a` to `b`,
-- and from `b` to `a`.
-- Going a roundway trip should leave you the same value.
-- Unfortunately it is virtually impossible to test this in Haskell.
-- This is called Isomorphism.

type ISO a b = (a -> b, b -> a)

-- given ISO a b, we can go from a to b
substL :: ISO a b -> (a -> b)
substL = fst

-- and vice versa
substR :: ISO a b -> (b -> a)
substR = snd

-- There can be more than one ISO a b
isoBool :: ISO Bool Bool
isoBool = (id, id)

isoBoolNot :: ISO Bool Bool
isoBoolNot = (not, not)

-- isomorphism is reflexive
refl :: ISO a a
refl = (\a -> id a, \a -> id a)

-- isomorphism is symmetric
symm :: ISO a b -> ISO b a
symm iso = (substR iso, substL iso)

-- isomorphism is transitive
trans :: ISO a b -> ISO b c -> ISO a c
<<<<<<< HEAD
trans (ab, ba) (bc, cb) = 
  (\a -> bc . ab, \c -> ba . cb)

-- We can combine isomorphism:
isoTuple :: ISO a b -> ISO c d -> ISO (a, c) (b, d)
isoTuple (ab, ba) (cd, dc) = 
  (\(a, c) -> (ab a, cd c), \(b, d) -> (ba b, dc d))

isoList :: ISO a b -> ISO [a] [b]
isoList (ab, ba) = 
  (\a -> [ab a], \b -> [ba b])

isoMaybe :: ISO a b -> ISO (Maybe a) (Maybe b)
isoMaybe (ab, ba) = 
  (\a -> Just (ab a), \b -> Just (ba b))

isoEither :: ISO a b -> ISO c d -> ISO (Either a c) (Either b d)
isoEither (ab, ba) (cd, dc) =
  ( \(a, c) -> Either (ab a) (cd c), \(b, d) -> Either (ba b) (dc d) )
=======
trans (ab, ba) (bc, cb) =
  (\a -> bc . ab $ a, \c -> ba . cb $ c)

-- We can combine isomorphism:
isoTuple :: ISO a b -> ISO c d -> ISO (a, c) (b, d)
isoTuple (ab, ba) (cd, dc) =
  (\(a, c) -> (ab a, cd c), \(b, d) -> (ba b, dc d))

isoList :: ISO a b -> ISO [a] [b]
isoList (ab, ba) = (fmap ab, fmap ba)

isoMaybe :: ISO a b -> ISO (Maybe a) (Maybe b)
isoMaybe (ab, ba) = (fmap ab, fmap ba)

isoEither :: ISO a b -> ISO c d -> ISO (Either a c) (Either b d)
isoEither (ab, ba) (cd, dc) =
  if True then (Left ab, Left ba)
  else (Right cd, Right ca)
>>>>>>> 5763d9c1389377b383a7ff51c0f3add6748f57c2

isoFunc :: ISO a b -> ISO c d -> ISO (a -> c) (b -> d)
isoFunc = error "do isoFunc"

-- Going another way is hard (and is generally impossible)
isoUnMaybe :: ISO (Maybe a) (Maybe b) -> ISO a b
<<<<<<< HEAD
=======
isoUnMaybe = error "do isoUnMaybe"

>>>>>>> 5763d9c1389377b383a7ff51c0f3add6748f57c2
-- Remember, for all valid ISO, converting and converting back
-- Is the same as the original value.
-- You need this to prove some case are impossible.

-- We cannot have
-- isoUnEither :: ISO (Either a b) (Either c d) -> ISO a c -> ISO b d.
-- Note that we have
isoEU :: ISO (Either [()] ()) (Either [()] Void)
isoEU = error "do isoEU"
-- where (), the empty tuple, has 1 value, and Void has 0 value
-- If we have isoUnEither,
-- We have ISO () Void by calling isoUnEither isoEU
-- That is impossible, since we can get a Void by substL on ISO () Void
-- So it is impossible to have isoUnEither

-- And we have isomorphism on isomorphism!
isoSymm :: ISO (ISO a b) (ISO b a)
<<<<<<< HEAD
isoSymm = error "do isoSymm"
=======
isoSymm = error "do isoSymm"
>>>>>>> 5763d9c1389377b383a7ff51c0f3add6748f57c2
