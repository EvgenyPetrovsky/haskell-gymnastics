# Casino rouluette game

`reoulette-definitions.hs` contains all definitions and actions necessary for gameplay. 

`roulette-doubling-stakes.hs` implements game strategy when every unseccessful game round leads to stakes doubling.  

## Use case

*Someone* (person) who *has money* goes to casino and *joins the game* table (that also defines *roulette style*). So this is *player*.

Player applies her *strategy* to win in *series of roulette spins' outcomes*.

Player is playing for *fixed time* (measured by *number of spins*) and uses *limited amount of money* she has. Game stops when *time is over* or if player runs *out of her money*.

Player plays *fair game* where winning number doesn't depend on stakes made.

Here is understanding (on resolution date)

## Building blocks ##

solution consists of 3 parts:
1. game defined separately
2. simulation framework defined separately; it is strategy agnostic
3. strategies defined separately

### who is Player

Player is a person with *balance*, *experience* (of previous games), *luck* (defines random generation) and *game* she is involved in. Player is part of game (1.) definitions. 

### what is Strategy

Strategy is a response of player represented in a set of Bets she does based on her balance and existing experience. Player has luck but no has idea on how to use it.

### what is Simulation

Simulation is framework that generates players and runs series of games. Simulation applies given strategies for series.
