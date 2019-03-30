module RouletteStrategy (
  doubleOnRedUntilWin
) where 

{-- 
  This file implements Strategies.

  Strategies are implemented as functions of **Strategy** type. 
  All working strategies should be registered in list of module functions. 
  Name of function should start with verb and contain short and sensible description.
--}

import RouletteDefinition 
import RouletteSimulation (Strategy)

{--
  implementation of one game round, always use one placement - Red
  if no experience - make minimun bet
  if some experience and last game was won - make 
--} 
doubleOnRedUntilWin :: Strategy
doubleOnRedUntilWin p 
  | balance p < minbet = initBets
  | null (experience p) = addBet (minbet, RedBet) initBets
  | lstpayout < 0 && dblbet <= maxbet = addBet (dblbet, RedBet) initBets
  | otherwise = addBet (minbet, RedBet) initBets
  where 
    minbet = minBet . game $ p
    maxbet = maxBet . game $ p
    lstgame = head . experience $ p
    lstpayout = payout lstgame
    dblbet = 2 * (betsCost . bets $ lstgame)
