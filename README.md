# Twitch Battles
Turnbased strategy game based on members of chat from Twitch.
The game is inspired by games like pokemon and final fantasy.

The game should include a rock-paper-scissor system of attack types.

## Battle Actions (Current)
- `attack`: damages the target using attacker `ap` (reduced by target `block` shield).
- `heal`: restores target HP using healer `he`.
- `block`: sets a shield using blocker `bp` (absorbs incoming attack damage).
- `boost`: targets an ally and increases their queued action value using booster `bm`:
  - boosts ally `attack` from ally `ap`
  - boosts ally `heal` from ally `he`
  - boosts ally `block` from ally `bp`
