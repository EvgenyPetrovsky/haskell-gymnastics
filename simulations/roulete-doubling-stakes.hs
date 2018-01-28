{--
This program implements algorithm of doubling stakes on roulete.
Rules: stake is made for red or green. If loss then double stake. If win then reset stake to minimum one
--}
type Outcome = Bool
type Balance = Integer

-- generates series of roulete launch outcomes. Assuming that game is fair and ouncome doesn't depend on anything
generateEvents :: [Outcome]

-- processes all roulete events and applies game strategy stops game if runs out of balance 
processEvents :: Balance -> [Outcome] -> Balance


