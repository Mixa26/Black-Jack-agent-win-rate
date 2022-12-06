# Black-Jack-agent-win-rate
A program evaluating the win rate of a simple black-jack agent

The agent works with given conditions:

If the sum of agents hand is equal or less than 15 we will HIT.
If the sum of agents hand is equal to 19,20 or 21 we will STAND.
If the sum of agents hand is above 15 but less than 19 the agent
will look at one card the house showed us, and if its value is
above our sum-10 than we will HIT, otherwise we will STAND.

The agent for the house works with the following conditions.

If the house's sum is less than our player's sum, the house
will HIT, else it will stand.

The player agent success percentage is about 0,352808 or ~35% measured at 1,000,000 runs.
