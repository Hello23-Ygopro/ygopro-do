## Rules
- [ ] **Only supported for 2 players**
- [ ] **If players tie for Victory points (VP), a player who tied but had fewer turns doesn't win**
- [ ] **If players have negative VP, their score shows 0**
- [ ] **Cards in the discard pile can't be shuffled**
- If you place cards from the discard pile onto your deck for an effect that requires more cards than are in your deck, the game will shuffle your deck.
- [x] **If you do the following with your deck, the game does not first put your discard pile onto your deck:**
	- [x] `Duel.ConfirmDecktop`: Looking/revealing more cards than are in your deck
	- [x] `Duel.SetAsideDeck`: Setting aside more cards than are in your deck
	- [x] `Duel.DiscardDeck`: Discarding more cards than are in your deck
	- [x] `Duel.TrashDeck`: Trashing more cards than are in your deck
- [ ] **You can't buy a card that costs 0 if you don't have any Treasure cards**
## Deck Building
- [x] **The 10 Kingdom cards are chosen at random at the start of the game**
- [ ] **The player who goes first chooses the set to play with**
## Zones
- [ ] **There are no [zones](https://yugioh.fandom.com/wiki/Zone) for cards in play**
- [Face-up](https://yugioh.fandom.com/wiki/Face-up) temporarily [banished](https://yugioh.fandom.com/wiki/Banish) cards are in play.
- [ ] **There are no zones for the [Trade Route](wiki.dominionstrategy.com/index.php/Trade_Route) mat**
- Check the Counter holder card to view the contents of the Trade Route mat (e.g. _Coin token(Trade Route mat)_)
## Cards
- [ ] **The following cards are not fully implemented**
	- [ ] Lighthouse(10003003): Doesn't prevent the opponent from making you gain cards (e.g. _Sea Hag_)
	- [ ] Native Village(10003004): There are no zones for the [Native Village mat](http://wiki.dominionstrategy.com/index.php/Mat#Player_mats).
	- [ ] Island(10003013): There are no zones for the Island mat.
	- [ ] Pirate Ship(10003015): There are no zones for the Pirate Ship mat.
	- [ ] Possession(10004013): Can't make decisions for the opponent.
## Card Effects
- [ ] **You don't always look through your entire deck when you take a card from it**
- If you're required to take a specific card from your deck, the game will only show you the relevant cards.
