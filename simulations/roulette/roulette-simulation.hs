module Roulete.Simulation (
    Strategy,
    runSimulations,
    generatePlayers
) where 

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

import Roulette.Definitions

type Strategy = Player -> [Bets]

{--
  Generate players for game.
  Input is required number of players to be generated; output is list of Players
--}
generatePlayers :: Int -> Balance -> [Player]
generatePlayers n b = 
  map (createPlayer balance) [1..n]
  where
    balance = b
    createPlayer bal luckyNum = 
      newPlayer bal (makeGenerator luckyNum)

{--
  Run simulation requires player, house and roulette, 
  luck of player (R.StdGen) defines 
--}
runSimulations :: Strategy -> [Player] -> [Player]
runSimulations s ps =
    map (runSimulation s) $ ps

{--
  Complete lifecycle of player in casino
  Fold. Zero element (house, player), over winning numbers, returns Player
--}
runSimulation :: Strategy -> Player -> Player
runSimulation s p =
    foldl (playOneRound p s) p pockets
    where 
        luck = luck p
        style = wheelStype . game $ p
        pockets = take gamesCount (winningNumbers style luck)

{--
  main builing block of simulation. Simulation consists of series of rounds
  for round we need 
  - player to make bets 
  - make payout based on winning number
  as a result of round we have "more experienced" Player with updated balance
--}
playOneRound :: Player -> Strategy -> Pocket -> Player
playOneRound p s w = 
    let
        begBal = balance p
        betAmt = betsCost bets
        endBal = begBal - betAmt + payout
        bets   = s p
        payout = gamePayout w bets
    in 
        Player {
            balance    = endBal,
            experience = (bets, w, payout) : (experience p),
            luck       = luck p,
            game       = game p
        }
    
{--
  example of strategy
--} 
strategyRed :: Player -> [Bets]
strategyRed p =
    addBet (RedBet, minBet . game $ p) initBets
