{-- House Rules --}
type Nominal = Integer
minBet = 10   :: Nominal
maxBet = 2000 :: Nominal

{-- Roulette definitions --}
data Color = Red | Black | Green
    deriving (Show, Eq)
data WheelStyle = SingleZero | DoubleZero
    deriving (Show, Eq)
type Pocket = Int
type WheelNumberSequence = [Pocket]

pocketSeq    :: WheelStyle -> WheelNumberSequence
pocketColor  :: Pocket -> Color
randomPocket :: WheelStyle -> Pocket

pocketSeq SingleZero =
    [0,32,15,19,4,21,2,25,17,34,6,27,13,36,11,30,8,23,10,5,24,16,33,1,20,14,31,9,22,18,29,7,28,12,35,3,26]
pocketSeq DoubleZero = 
    [0,28,9,26,30,11,7,20,32,17,5,22,34,15,3,24,36,13,1,0,27,10,25,29,12,8,19,31,18,6,21,33,16,4,23,35,14,2]

pocketColor n
    | elem n $ [ 1..10] ++ [19..28] = ebor
    | elem n $ [11..18] ++ [29..36] = erob
    | n == 0 = Green
    | otherwise = error "Unreachable point"
    where
        ebor = if (even n) then Black else Red
        erob = if (even n) then Red else Black

randomPocket SingleZero = error "not implemented"
randomPocket DoubleZero = error "not implemented"

{-- table definitions --}
type TableLayout = WheelStyle
getTableLayout :: WheelStyle -> TableLayout
getTableLayout w = w :: TableLayout

{-- Bet definitions --}
data BetPlacement = InsideBet | OutsideBet

data InsideBet = 
    Straight Pocket | 
    SplitH Pocket | SplitV Pocket | 
    Street Pocket | 
    Corner Pocket |
    SixLine Pocket | DoubleStreet Pocket |
    Trio Pocket Pocket Pocket|
    Basket | FirstFour |
    TopLine
    deriving (Eq, Show)

data OutsideBet = 
    Low | High |
    RedColor | BlackColor |
    Even | Odd |
    DozenFirst | DozenSecond | DozenThird |
    ColumnOne | ColumnTwo | ColumnThree |
    Snake
    deriving (Eq, Show)
    
type Bet = (Nominal, BetPlacement)
    
isValid :: BetPlacement -> Bool
isValid bet = False

toPockets :: BetPlacement -> [Pocket]
toPockets = error "not implemented"

addBet :: Bet -> [Bet] -> [Bet]
addBet bet bets = error "not implemented"

initBets :: [Bet] 
initBets = []

{-- Game definitions --}
calculatePayout :: Pocket -> [Bet] -> Nominal
calculatePayout = error "not implemented"