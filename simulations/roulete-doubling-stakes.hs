{--
This program implements algorithm of doubling stakes on roulete.
Rules: stake is made for red or green. If loss then double stake. If win then reset stake to minimum one
--}
type Outcome = Bool
type Money   = Float
type Balance = Money
type Stake   = Money

smallestStake :: Stake
smallestStake = 1

startBalance  :: Balance
startBalance  = 100

-- play Game

playGame :: Balance
playGame = processEvents startBalance generateEvents smallestStake

-- generates series of random roulete launch outcomes. Assuming that game is fair and outcome doesn't depend on anything
generateEvents :: [Outcome]
generateEvents = error "No implementation"
--generateEvents = [l, l, l, w, l, l, l, w, l, l, l, l, l]
  where 
    l = False
    w = True

-- processes all roulete events and applies game strategy stops game if runs out of balance 
processEvents :: Balance -> [Outcome] -> Stake -> Balance

processEvents balance [] stake = 
  balance + stake
processEvents balance (result:results) stake
  | balance <= 0  = balance
  | result == win = processEvents (balance + wonMoney) results smallestStake
  | otherwise     = processEvents (balance - newStake) results newStake
  where 
    win      = True
    newStake = stake * 2
    wonMoney = stake * 2 * 0.98





