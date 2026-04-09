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

## Cartdata Layout
The cart uses `cartdata('pico-q2n')`.

- 0: `max_team_size`
- 1: active team slot 1 as `roster_ids` index
- 2: active team slot 2 as `roster_ids` index
- 3: active team slot 3 as `roster_ids` index
- 4: `unlocked_chars`
- 5: `unlocked_levels`

Notes:
- Active team entries are stored as indices into `roster_ids`, not as character ids.
- `0` means "empty / unset" for team slots.
- When save data is missing, defaults are initialized on boot.

## SFXs
0. ui fx
1. attack
2. heal
3. block
4. boost
5. death
6. victory
7. defeat


# TODO
- [] particle system
- [] animate battle
- [] sfx
- [] music
