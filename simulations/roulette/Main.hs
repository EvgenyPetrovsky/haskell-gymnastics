import System.Environment
import qualified RouletteDefinition as Def
import qualified RouletteSimulation as Sim
import qualified RouletteStrategy as Str
 
main :: IO ()
main = do
    args <- getArgs
    putStrLn "simulation input:"
    putStrLn $ " < number of simulations: " ++ (show num)
    putStrLn $ " < initial balance:       " ++ (show num)
    putStrLn $ " < game: " ++ (show game)
    putStrLn $ "----------------------------------------"
    putStrLn $ "simulation results summary:"
    putStrLn $ showResultSummary simulation
    putStrLn $ "----------------------------------------"
    putStrLn $ "simulation results details:"
    mapM_ putStrLn $ map showResult simulation

showResult :: Def.Player -> String
showResult p =
    " > balance: " ++ (show bal) ++ ", wins: " ++ (show wins)
    where 
        bal  = Def.balance p
        wins = length $ filter (\e -> Def.payout e > 0) (Def.experience p)

showResultSummary :: [Def.Player] -> String
showResultSummary ps = 
    " > average gain: " ++ (show avgGain) ++ ", percent of wins: " ++ (show pctWins)
    where 
        payouts = map (\x -> Def.balance x - bal) ps
        average x = 
            x `div` num
        avgGain = average $ sum payouts
        pctWins = average $ 100 * length ( filter (\x -> x > 0) payouts )

{-- Parameters --}
num  = 100 
bal  = 5000 :: Def.Nominal
game = Def.Game { Def.minBet = 10, Def.maxBet = 2000, Def.wheelStyle = Def.SingleZero, Def.maxGames = 100 }    
seed = 123  :: Def.GenSeed


{-- Simple simulation run --}
simulation :: [Def.Player]
simulation = 
    let 
        ps = Sim.generateNPlayers num seed bal game
    in
        Sim.runSimulations Str.doubleOnRedUntilWin ps
