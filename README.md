# YGOPro DO

<p align="center">
	<img src="https://user-images.githubusercontent.com/18324297/87833012-8d00c700-c887-11ea-89e7-5d575adc2a2d.png">
</p>

## How to play
1. Start YGOPro.
2. Host a game and select a [deck](http://wiki.dominionstrategy.com/index.php/Deck) that has at least 5 cards.
3. When setting up a game, each player takes 3 [Estates](http://wiki.dominionstrategy.com/index.php/Estate) and 7 [Coppers](http://wiki.dominionstrategy.com/index.php/Copper) and shuffles them face down as a starting deck.<br>
Put out 17 face-up piles of cards on the table: the 7 [Base](http://wiki.dominionstrategy.com/index.php/Basic_cards) cards piles, which are always used, and always the same, and 10 [Kingdom](http://wiki.dominionstrategy.com/index.php/Kingdom) card piles, which vary from game to game. The full set of cards available this game is called the [Supply](http://wiki.dominionstrategy.com/index.php/Supply). The Base cards are Copper (46), [Silver](http://wiki.dominionstrategy.com/index.php/Silver) (40), [Gold](http://wiki.dominionstrategy.com/index.php/Gold) (30), Estate (8), [Duchy](http://wiki.dominionstrategy.com/index.php/Duchy) (8), [Province](http://wiki.dominionstrategy.com/index.php/Province) (8), and [Curse](http://wiki.dominionstrategy.com/index.php/Curse) (10).<br>
Choose 10 Kingdom cards to use, however you like. You can pick them randomly. Whichever 10 cards you pick, get out those piles - 10 copies of each card. When a [Victory](http://wiki.dominionstrategy.com/index.php/Victory_card) Kingdom card is used (e.g. [Gardens](http://wiki.dominionstrategy.com/index.php/Gardens)), it gets 8 copies for 2 players, as with the other Victory cards.
4. Each player [draws](http://wiki.dominionstrategy.com/index.php/Draw) an initial hand of 5 cards.
5. During your [Action phase](http://wiki.dominionstrategy.com/index.php/Gameplay#Action_phase), you can play one [Action](http://wiki.dominionstrategy.com/index.php/Action#Action_cards) card from your hand. If you cannot do everything a card tells you to do, you do as much as you can; you can still play a card even if you know you will not be able to do everything it tells you to.<br>
Some cards give "+1 Action". This increases how many Action cards you can play in a [turn](http://wiki.dominionstrategy.com/index.php/Turn).<br>
Using up your Actions is optional; you can have an Action card left in hand that you can play, and decide not to play it.
6. During your [Buy phase](http://wiki.dominionstrategy.com/index.php/Gameplay#Buy_phase), you can play any number of [Treasure](http://wiki.dominionstrategy.com/index.php/Treasure) cards from your hand, in any order. Then, you can buy one card, costing as much $ (coins) as you have or less. You buy a card by choosing it from the Supply, and then "gaining" it. "Gaining" a card means moving it from the Supply to your [discard pile](http://wiki.dominionstrategy.com/index.php/Discard). Your total amount of [coins](http://wiki.dominionstrategy.com/index.php/Coin) available to spend goes down by the cost of the card.<br>
Some cards give "+1 Buy". This increases how many cards you can buy in a turn in your Buy phase.<br>
You cannot go back and play more Treasures after buying a card; first play Treasures, then buy.
7. During your [Clean-up phase](http://wiki.dominionstrategy.com/index.php/Gameplay#Clean-up_phase), take all of the cards you have in play (both Actions and Treasures), and any remaining cards in your hand, and put them all into your discard pile.<br>
Draw a new hand of 5 cards. If your deck has fewer than 5 cards, first shuffle your discard pile and put it under your deck, then draw.<br>
Play passes to the player to your left. Any unused +Actions, unused +Buys, or unspent coins that you had left are gone; you start each turn fresh.

**Important:**
1. This YGOPro game is only compatible with the Microsoft Windows operating system.
2. Online play is not supported.
3. At least 1 player must have _Dominion Rules_ in their deck, and each player must have at least 5 cards in their deck, otherwise the mod will not function properly.
4. Enable `Do not check Deck` when creating a game to avoid an error due to a player having less than 40 cards in their deck.

## How to win
1. The game ends at the end of a turn, if either the Province pile is empty, or any three or more Supply piles are empty (any piles at all, including Kingdom cards, Curses, Copper, etc.).<br>
Take all of your cards - from your hand, deck, discard pile, play area, and even set aside cards. Count up your [Victory points](http://wiki.dominionstrategy.com/index.php/Victory_point) (VP). The player with the most VP wins. If players tie for VP, a player who tied but had fewer turns wins. If players tie and had the same number of turns, they rejoice in their shared victory.

## Extra information
<details>
<summary>OT (OCG/TCG)</summary>

- `0x1	OCG` = OCG only card
- `0x2	TCG` = TCG only card
- `0x3	OCG+TCG` = OCG + TCG card
- `0x4	Anime/Custom` = Unofficial card
</details>
<details>
<summary>Card Type</summary>

- `0x3	Monster+Spell` = Action
- `0x5	Monster+Trap` = Treasure
- `0x21	Monster+Effect` = Victory
- `0x81	Monster+Ritual` = Curse
- `0x100	Trap Monster` = [Attack](http://wiki.dominionstrategy.com/index.php/Attack)
- `0x200	Spirit` = [Reaction](http://wiki.dominionstrategy.com/index.php/Reaction)
	- `Level` = Cost
</details>
<details>
<summary>Location</summary>

- `0x4	Monster Zone` = P1 Sequence 0~4: Top half Kingdom cards (Supply) + P2 Sequence 0~2: Victory cards (Base) + Sequence 5~6: [Events](http://wiki.dominionstrategy.com/index.php/Event)
- `0x8	Spell & Trap Zone` = P1 Sequence 0~4: Bottom half Kingdom cards (Supply) + P2 Sequence 0~2: Treasure cards (Base) + P2 Sequence 3: Curse cards (Base)
- `0x10	Graveyard` = Discard pile
- `0x20	Banished` = [Trash](http://wiki.dominionstrategy.com/index.php/Trash)
- `0x40	Extra Deck` = ～Reserved～
</details>
<details>
<summary>Phase</summary>

1. `EVENT_PREDRAW` = ～Reserved～
2. `PHASE_DRAW` = Action phase (A)
3. `PHASE_STANDBY` = Buy phase (B)
4. `PHASE_MAIN1` = Clean-up phase (C)
5. `PHASE_BATTLE` = ～Reserved～
6. `PHASE_MAIN2` = ～Reserved～
7. `PHASE_END` = ～Reserved～
</details>
<details>
<summary>Category</summary>

- `0x1	Destroy Spell/Trap` = ～Reserved～
- `0x2	Destroy Monster` = ～Reserved～
- `0x4	Banish Card` = Trash
- `0x8	Send to Graveyard` = ～Reserved～
- `0x10	Return to Hand` = Add to Hand
- `0x20	Return to Deck` = Add to Deck
- `0x40	Destroy Hand` = Discard Hand
- `0x80	Destroy Deck` = Discard Deck
- `0x100	Increase Draw` = Draw Draw
- `0x200	Search Deck` = ～Reserved～
- `0x400	GY to Hand/Field` = ～Reserved～
- `0x800	Change Battle Position` = ～Reserved～
- `0x1000	Get Control` = Gain Card
- `0x2000	Increase/Decrease ATK/DEF` = ～Reserved～
- `0x4000	Piercing` = ～Reserved～
- `0x8000	Attack Multiple Times` = +Action
- `0x10000	Limit Attack` = ～Reserved～
- `0x20000	Direct Attack` = ～Reserved～
- `0x40000	Special Summon` = ～Reserved～
- `0x80000	Token` = ～Reserved～
- `0x100000	Type-related` = ～Reserved～
- `0x200000	Attribute-related` = ～Reserved～
- `0x400000	Reduce LP` = -VP
- `0x800000	Increase LP` = +VP
- `0x1000000	Cannot Be Destroyed` = ～Reserved～
- `0x2000000	Cannot Be Targeted` = ～Reserved～
- `0x4000000	Counter` = +Buy
- `0x8000000	Gamble` = +Coin
- `0x10000000	Fusion` = ～Reserved～
- `0x20000000	Synchro` = ～Reserved～
- `0x40000000	Xyz` = ～Reserved～
- `0x80000000	Negate Effect` = ～Reserved～
</details>
<details>
<summary>Card Search</summary>

You can search for the following specific card information in YGOPro. (Note: Select `All` in the `Type` tab to be able to filter Victory, Curse, and Reaction cards.)
- Card Type: Use the `Type` tab
- Cost: Use the `Cost` tab
- You can also search for cards whose abilities have been modified for YGOPro by typing `YGOPro`.
</details>
