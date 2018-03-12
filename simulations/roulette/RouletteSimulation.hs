module RouletteSimulation (
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

import RouletteDefinition

type Strategy = Player -> [Bet]

{--
  Generate players for game.
  Input is required number of players to be generated; output is list of Players
--}
generatePlayers :: Int -> Balance -> Game -> [Player]
generatePlayers num bal game = 
  map (createPlayer) [1..num]
  where
    createPlayer luckyNum = 
      newPlayer bal (makeGenerator luckyNum) game

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
    foldl fun p pockets
    where 
        luck' = luck p
        style = wheelStyle . game $ p
        pockets = take (maxGames . game $ p) (winningNumbers style luck')
        fun player pocket = playOneRound player s pocket

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
        latest = PlayedGame {
            bets = bets, 
            winningNumber = w, 
            payout = payout
        }
    in 
        Player {
            balance    = endBal,
            experience = latest : (experience p),
            luck       = luck p,
            game       = game p
        }
    
{--
  example of strategy implementation. 
  type Strategy = Player -> [Bet]
  implements doubleOnRedUntilWin
--} 

strategyExample :: Strategy
strategyExample p
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


{--
    Example of running simulation
--}
simulationExample :: [Player]
simulationExample =
    let b  = 5000
        c  = 100
        g  = Game { minBet = 10, maxBet = 2000, wheelStyle = SingleZero, maxGames = c }
        ps = generatePlayers 100 b g
    in
        runSimulations strategyExample ps
