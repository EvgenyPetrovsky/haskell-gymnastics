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

import RouletteDefinition 

{--
  implementation of one game round, always use one placement - Red
  if no experience - make minimun bet
  if some experience and last game was won - make 
--} 
strategyRed :: Player -> [Bet]
strategyRed p 
  | balance p < minbet = initBets
  | null (experience p) = addBet (minbet, RedBet) initBets
  | lstpayout == 0 && dblbet <= maxbet = addBet (dblbet, RedBet) initBets
  | otherwise = addBet (minbet, RedBet) initBets
  where 
    minbet = minBet . game $ p
    maxbet = maxBet . game $ p
    lstgame = head . experience $ p
    lstpayout = payout lstgame
    dblbet = 2 * (betsCost . bets $ lstgame)
