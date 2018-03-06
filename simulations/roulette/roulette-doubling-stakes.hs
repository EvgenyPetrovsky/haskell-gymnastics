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


gamesCount = 100

{--
  Generate players for game.
  Input is required number of players to be generated; output is list of Players
--}
generatePlayers :: Int -> [Player]
generatePlayers n b = 
  map (createPlayer balance) [1..n]
  where
    balance = b
    createPlayer bal luckyNum = 
      initPlayer bal (makeGenerator luckyNum)


{--
  Run simulation requires player, house and roulette, 
  luck of player (R.StdGen) defines 
--}
runManySimulations :: Int -> [Player]
runManySimulations n =
  map (\p -> runSimulation p house) $ generatePlayers n
  where
    house = RD.defaultHouse

{--
  Complete lifecycle of player in casino
  Fold. Zero element (house, player), over winning numbers, returns Player
--}
runSimulation :: Player -> House -> Player
runSimulation p h =
  fold? pockets p
  where 
    luck = luck p
    style = wheelStype h
    pockets = take gamesCount (winningNumbers style luck)

{--
  implementation of one game round, always use one placement - Red
  if no experience - make minimun bet
  if some experience and last game was won - make 
--} 
strategyRed :: House -> Player -> Pocket -> Player
iter pcts h p = 
  if experience p == [] then

  else 

-- check balance; play round; extend experience
playTheGame

data Player = 
