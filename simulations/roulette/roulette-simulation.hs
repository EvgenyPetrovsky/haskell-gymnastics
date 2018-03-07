{-- 
  This file implements generic simulation framework

  simulations are generated according to input parameters.
  strrategy to be applied to the game is also passed as input parameter
  
  strategy must be represented as function with signature
  strategy :: Player -> Player
  simuation framework gives Player with its experiene to strategy and it returns new Bet
  then payout is determined bassed on winning number
  then new player with updated experience and balance is updated according to payout

  everything starts again untill all games are playes

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
runSimulation :: Player -> Game -> Player
runSimulation p h =
  fold? pockets p
  where 
    luck = luck p
    style = wheelStype h
    pockets = take gamesCount (winningNumbers style luck)

-- apply strategy-> Bet, make bet >> calculate payout >> repeat


{--
  example of strategy
--} 
strategyRed :: Player -> Game -> Player
strategyRed p g =
  addBet (RedBet, minBet) initBets
