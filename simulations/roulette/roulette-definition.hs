import qualified System.Random as R

{-- House Rules --}
type Nominal = Int
minBet = 10   :: Nominal
maxBet = 2000 :: Nominal

{-- Roulette definitions --}
data Color = Red | Black | Green
    deriving (Show, Eq)
data WheelStyle = SingleZero | DoubleZero
    deriving (Show, Eq)
type Pocket = Int
type WheelNumberSequence = [Pocket]

pocketSeq     :: WheelStyle -> WheelNumberSequence
pocketColor   :: Pocket -> Color
pocketByIdx   :: WheelStyle -> Int -> Pocket

pocketSeq SingleZero =
    [0,32,15,19,4,21,2,25,17,34,6,27,13,36,11,30,8,23,10,5,24,16,33,1,20,14,31,9,22,18,29,7,28,12,35,3,26]
-- 00 represented as -1
pocketSeq DoubleZero = 
    [0,28,9,26,30,11,7,20,32,17,5,22,34,15,3,24,36,13,1,-1,27,10,25,29,12,8,19,31,18,6,21,33,16,4,23,35,14,2]

pocketByIdx ws idx = pocketSeq ws !! idx

pocketColor n
    | elem n $ [ 1..10] ++ [19..28] = ebor
    | elem n $ [11..18] ++ [29..36] = erob
    | n == 0 = Green
    | otherwise = error "Unreachable point"
    where
        ebor = if (even n) then Black else Red
        erob = if (even n) then Red else Black

{-- table definitions --}
type TableLayout = WheelStyle
getTableLayout :: WheelStyle -> TableLayout
getTableLayout w = w :: TableLayout

{-- Bet definitions --}
data BetPlacement = 
    -- Bet on a single number
    Straight Pocket | 
    -- Bet on two vertically/horizontally adjacent numbers (e.g. 14-17 or 8-9)
    SplitH Pocket | SplitV Pocket | 
    -- Bet on three consecutive numbers in a horizontal line (e.g. 7-8-9)
    Street Pocket | 
    -- Bet on four numbers that meet at one corner (e.g. 10-11-13-14)
    Corner Pocket |
    -- Bet on six consecutive numbers that form two horizontal lines (e.g. 31-32-33-34-35-36)
    SixLine Pocket | DoubleStreet Pocket |
    -- A three-number bet that involves at least one zero: 0-1-2 (either layout); 0-2-3 (single-zero only); 0-00-2 or 00-2-3 (double-zero only)
    Trio Pocket Pocket Pocket |
    -- Bet on 0-1-2-3 (Single-zero layout only)
    Basket | FirstFour |
    -- Bet on 0-00-1-2-3 (Double-zero layout only)
    TopLine |

    -- Outside bets
    Low | High |
    RedBet | BlackBet |
    Even | Odd |
    DozenFirst | DozenSecond | DozenThird |
    ColumnOne | ColumnTwo | ColumnThree |
    Snake
    deriving (Eq, Show)
    
type Bet = (Nominal, BetPlacement)
    
isValid :: BetPlacement -> Bool
isValid bet = 
    -- Check placement. m represents leftmost topmost position
    True

toPockets :: BetPlacement -> [Pocket]
toPockets (Straight n)     = [n]
toPockets (SplitH n)       = [n, n + 1]
toPockets (SplitV n)       = [n, n + 3]
toPockets (Street n)       = [n .. n + 2]
toPockets (Corner n)       = [n, n + 1, n + 3, n + 4]
toPockets (SixLine n)      = [n .. n + 5]
toPockets (DoubleStreet n) = toPockets (SixLine n)
toPockets (Trio x y z)     = [x, y, z]
toPockets Basket    = [0 .. 3]
toPockets FirstFour = toPockets Basket
toPockets TopLine   = [-1 ..  3]
toPockets Low       = [ 1 .. 18]
toPockets High      = [19 .. 36]
toPockets RedBet    = filter (\p -> Red == pocketColor p) [1 .. 36]
toPockets BlackBet  = filter (\p -> Black == pocketColor p) [1 .. 36]
toPockets Even      = filter even [1 .. 36]
toPockets Odd       = filter odd  [1 .. 36]
toPockets _ = error "not implemented"

includesPocket :: [Pocket] -> Pocket -> Bool
includesPocket ns n = elem n ns

{-- Game definitions --}
generatePockets :: WheelStyle -> R.StdGen -> [Pocket]

generatePockets ws gen = 
    map getPocketByIdx $ R.randomRs (1, pctCount) gen
    where
        pctCount = length $ pocketSeq ws
        getPocketByIdx = \x -> pocketByIdx ws (x - 1)

makeGenerator :: Int -> R.StdGen
makeGenerator = R.mkStdGen

newGenerator  :: IO R.StdGen
newGenerator = R.newStdGen
        
initBets :: [Bet] 
initBets = []

addBet :: Bet -> [Bet] -> [Bet]
-- add (if valid) into stack of other bets
addBet bet bets = 
    if isValid placement && nominal >= 0
        then bet : bets
        else bets
    where (nominal, placement) = bet

gamePayout :: Pocket -> [Bet] -> Nominal
gamePayout p bs = sum $ map (\b -> betPayout p b) bs

betPayout :: Pocket -> Bet -> Nominal
betPayout pocket (nominal, placement)
    | pockets `includesPocket` pocket = (nominal * 36) `div` qty - nominal
    | otherwise = 0
    where 
        pockets = (toPockets placement)
        qty = length pockets
