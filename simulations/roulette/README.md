# Casino rouluette game

`reoulette-definitions.hs` contains all definitions and actions necessary for gameplay. 

`roulette-doubling-stakes.hs` implements game strategy when every unseccessful game round leads to stakes doubling.  

## Use case

*Someone* (person) who *has money* goes to casino and *joins the game* table (that also defines *roulette style*). So this is *player*.

Player applies her *strategy* to win in *series of roulette spins' outcomes*.

Player is playing for *fixed time* (measured by *number of spins*) and uses *limited amount of money* she has. Game stops when *time is over* or if player runs *out of her money*.

Player plays *fair game* where winning number doesn't depend on stakes made.
