## Rules
- [ ] **Only supported for 2 players**
- [ ] **If players tie for Victory points (VP), a player who tied but had fewer turns doesn't win**
## Deck Building
- [ ] **The 10 Kingdom cards are chosen at random at the start of the game**
## Zones
- [ ] **There are no [zones](https://yugioh.fandom.com/wiki/Zone) for cards in play**
- [Face-up](https://yugioh.fandom.com/wiki/Face-up) temporarily [banished](https://yugioh.fandom.com/wiki/Banish) cards are in play.
## Card Effects
- [ ] **You don't always look through your entire deck when you take a card from it**
- If you're required to take a specific card from your deck, the game will only show you the relevant cards.
- [ ] **If you do the following with your deck, the game does not first put your discard pile onto your deck:**
	- [ ] `Duel.ConfirmCards`: Looking at more cards than are in your deck
	- [ ] `TBA`: Setting aside more cards than are in your deck
	- [x] `Duel.DiscardDeck`: Discarding more cards than are in your deck
	- [ ] `Duel.SendtoDPile(targets,reason+REASON_DISCARD,target_player)`: Discarding more cards than are in your deck
	- [ ] `Duel.Trash`: Trashing more cards than are in your deck
