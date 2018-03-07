{-- 
  This file implements doubling stakes strategy.

  Idea is to make minimum bet for the color
  Make a bet (reduce balance)
  If color does not win then double stake
  If color wins then add won money to balance and reset stake to minimum

  repeat until 
  * either balance becomes less than we can use for bet
  * or all games are over
--}

import qualified Roulette.Definitions as RD
import qualified Roulette.Simulations as RS

{--
  implementation of one game round, always use one placement - Red
  if no experience - make minimun bet
  if some experience and last game was won - make 
--} 
strategyRed :: Player -> Game -> Player
strategyRed p g = 
  if noExperience p then 
    addBet (RedBet, minBet) initBets
  else if lastPayout == 0 && dblBet <= maxBet
    addBet (RedBet, dblBet) initBets
  else 
    addBet (RedBet, minBet) initBets
  where 
    noExperience p = experience p == []
    minBet = minBet g
    maxBet = maxBet g
    lastBet = head . experience $ p
    lastPayout = payout lastBet
    lastBetCost = betsCost lastBet
    dblBet = lastBetCost * 2