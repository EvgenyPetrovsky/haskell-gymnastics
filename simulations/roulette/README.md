# Casino rouluette game

Implementation of casino roulette game: defintion, simulation, strategies. 
Aim is to test how specific strategies work in *real* environment: with number of games and bet limitations. This implementation describes game from player point of view and not house point of view. The difference for example is in how to manage many players who are involved in a game. Implementation supports both american (double-zero) and european (single-zero) wheel styles.

## Subject matter

*Someone* (person) who *has money* goes to casino and *joins the game* table (that also defines *roulette style*). So this is *player*. Player has to follow house rules: can play limited number of games (?) and has limit on minimum and maximum amount of bet.

Player applies her *strategy* to win in *series of roulette spins' outcomes*.

Player is playing for *fixed time* (measured by *number of spins*) and uses *limited amount of money* she has. Game stops when *time is over* or if player runs *out of her money*.

Player plays *fair game* where winning number doesn't depend on stakes made.

## Building blocks

solution consists of 3 parts:

1. *Roulette Definition* (`RouletteDefinition.hs`) - rules of roulete game
1. *Roulette Simulation* (`RouletteSimulation.hs`) - simulation framework; it is game strategy agnostic
1. *Roulette Strategy* (`RouletteStrategy.hs`) - strategies defined as a functions that react on input

### who is Player

Player is a person with *balance*, *experience* (bets and payout of previous games), *luck* (defines random generation) and *game* (wheel style, min and max bet amounts allowed) she is involved in. Player is part of *Roulette Definition*.

### what is Strategy

Strategy is a response of player represented in a set of Bets she does based on her balance and existing experience. Player has luck but no has idea on how to use it. Player doesn't know what number is going to win. Player is responsible to make right bet. If bet exceeds balance or limit then it will be rejected by simulation.

### what is Simulation

Simulation is framework that generates players, involves into games and runs series of games. Simulation applies given strategies for series. As an output of simulations we have players with their experience after games.

## how to use

*Roulette Simulation* (`RouletteSimulation.hs`) contains `simulationExample` function that takes no parameters and returns result of simulation. Executing simulation requires following steps:

1. create `Game`;
2. generate `Player`-s;
3. run simulation (`runSimulations`) applying `Strategy` to `Player`-s.
