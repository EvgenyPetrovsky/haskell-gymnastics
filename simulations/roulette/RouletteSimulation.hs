module RouletteSimulation (
    Strategy,
    runSimulations,
    generatePlayers,
    generateNPlayers
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
  Input is lucks, balance and game
--}
generatePlayers :: [Luck] -> Balance -> Game -> [Player]
generatePlayers ls bal game = 
  map (\luck -> newPlayer bal luck game) ls

{--
  Generate players for game.
  Input is required number of players to be generated and seed
--}
generateNPlayers :: Int -> GenSeed -> Balance -> Game -> [Player]
generateNPlayers n seed bal game = 
  map (createPlayer) [seed+1 .. seed+n]
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
        bal = balance p
        sbt = s p
        bets = if (betsCost sbt) > bal then [] else sbt
        payout = gamePayout w bets
        latest = PlayedGame {
            bets = bets, 
            winningNumber = w, 
            payout = payout
        }
    in 
        Player {
            balance    = bal + payout,
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
    | lstpayout < 0 && dblbet <= maxbet = addBet (dblbet, RedBet) initBets
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
    let bal   = 5000
        num   = 100
        game  = Game { minBet = 10, maxBet = 2000, wheelStyle = SingleZero, maxGames = 100 }
        seed  = 123
        ps = generateNPlayers num seed bal game
    in
        runSimulations strategyExample ps
