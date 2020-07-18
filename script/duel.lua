--Overwritten Duel functions
--reveal the top cards of a player's deck
--Note: Overwritten to put the discard pile onto the deck
local duel_confirm_decktop=Duel.ConfirmDecktop
function Duel.ConfirmDecktop(player,count)
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,player,LOCATION_DPILE,0,nil)
	if count>deck_count and g:GetCount()>0 then
		Duel.SendtoDeck(g,player,SEQ_DECK_SHUFFLE,REASON_RULE)
		Duel.ShuffleDeck(player)
	end
	if deck_count>0 and count>deck_count and g:GetCount()==0 then count=deck_count end
	return duel_confirm_decktop(player,count)
end
--draw a card
--Note: Overwritten to put the discard pile onto the deck
local duel_draw=Duel.Draw
function Duel.Draw(player,count,reason)
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,player,LOCATION_DPILE,0,nil)
	if count>deck_count and g:GetCount()>0 then
		Duel.SendtoDeck(g,player,SEQ_DECK_SHUFFLE,REASON_RULE)
		Duel.ShuffleDeck(player)
	end
	if deck_count>0 and count>deck_count and g:GetCount()==0 then count=deck_count end
	return duel_draw(player,count,reason)
end
--check if a player can draw a card
--Note: Overwritten to check if a player's deck size is less than the number of cards they will draw
local duel_is_player_can_draw=Duel.IsPlayerCanDraw
function Duel.IsPlayerCanDraw(player,count)
	count=count or 0
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,player,LOCATION_DPILE,0,nil)
	if deck_count>0 and count>deck_count and g:GetCount()==0 then count=deck_count end
	return duel_is_player_can_draw(player,count)
end
--discard the top cards of a player's deck
--Note: Overwritten to put the discard pile onto the deck
local duel_discard_deck=Duel.DiscardDeck
function Duel.DiscardDeck(player,count,reason)
	local res=0
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	local g1=Duel.GetMatchingGroup(Card.IsAbleToDeck,player,LOCATION_DPILE,0,nil)
	if count>deck_count and g1:GetCount()>0 then
		Duel.SendtoDeck(g1,player,SEQ_DECK_SHUFFLE,REASON_RULE)
		Duel.ShuffleDeck(player)
	end
	if deck_count>0 and count>deck_count and g1:GetCount()==0 then count=deck_count end
	--fix some cards sent to the wrong player's discard pile
	if Duel.IsPlayerCanDiscardDeck(player,count) then
		local g2=Duel.GetDecktopGroup(player,count)
		Duel.DisableShuffleCheck()
		res=res+Duel.SendtoDPile(g2,reason+REASON_DISCARD,player)
	end
	return res
end
--select a card
--Note: Overwritten to notify a player if there are no cards to select
local duel_select_matching_card=Duel.SelectMatchingCard
function Duel.SelectMatchingCard(sel_player,f,player,s,o,min,max,ex,...)
	if not Duel.IsExistingMatchingCard(f,player,s,o,1,ex,...) then
		Duel.Hint(HINT_MESSAGE,sel_player,ERROR_NOTARGETS)
	end
	return duel_select_matching_card(sel_player,f,player,s,o,min,max,ex,...)
end
--target a card
--Note: Overwritten to notify a player if there are no cards to select
local duel_select_target=Duel.SelectTarget
function Duel.SelectTarget(sel_player,f,player,s,o,min,max,ex,...)
	if not Duel.IsExistingTarget(f,player,s,o,1,ex,...) then
		Duel.Hint(HINT_MESSAGE,sel_player,ERROR_NOTARGETS)
	end
	return duel_select_target(sel_player,f,player,s,o,min,max,ex,...)
end
--New Duel functions
--generate a card
function Duel.CreateCard(player,code)
	--player: the player who generates the card
	--code: the id of the card to generate
	return Duel.CreateToken(player,code)
end
--end the turn
function Duel.EndTurn()
	local turnp=Duel.GetTurnPlayer()
	Duel.SkipPhase(turnp,PHASE_ACTION,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(turnp,PHASE_BUY,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(turnp,PHASE_CLEANUP,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(turnp,PHASE_BATTLE,RESET_PHASE+PHASE_END,1,1)
	Duel.SkipPhase(turnp,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
	local ct1=Duel.GetActions(turnp)
	local ct2=Duel.GetBuys(turnp)
	local ct3=Duel.GetCoins(turnp)
	if ct1>0 then Duel.RemoveAction(turnp,ct1) end
	if ct2>0 then Duel.RemoveBuy(turnp,ct2) end
	if ct3>0 then Duel.RemoveCoin(turnp,ct3) end
end
--get a player's counter holder (not available in the official game)
--Note: returns Card if player~=nil, otherwise returns Group
function Duel.GetCounterHolder(player)
	if player then
		return Duel.GetFirstMatchingCard(Card.IsCode,player,LOCATION_SUPPLY,0,nil,CARD_COUNTER_HOLDER)
	else
		return Duel.GetMatchingGroup(Card.IsCode,0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,CARD_COUNTER_HOLDER)
	end
end
--increase a player's actions
function Duel.AddAction(player,count)
	--player: the player to add the actions to
	--count: the amount of actions to add
	return Duel.GetCounterHolder(player):AddCounter(COUNTER_ACTIONS,count)
end
--increase a player's buys
function Duel.AddBuy(player,count)
	--player: the player to add the buys to
	--count: the amount of buys to add
	return Duel.GetCounterHolder(player):AddCounter(COUNTER_BUYS,count)
end
--increase a player's coins
function Duel.AddCoin(player,count)
	--player: the player to add the coins to
	--count: the amount of coins to add
	return Duel.GetCounterHolder(player):AddCounter(COUNTER_COINS,count)
end
--decrease a player's actions
function Duel.RemoveAction(player,count)
	--player: the player to remove the actions from
	--count: the amount of actions to remove
	return Duel.GetCounterHolder(player):RemoveCounter(player,COUNTER_ACTIONS,count,REASON_RULE)
end
--decrease a player's buys
function Duel.RemoveBuy(player,count)
	--player: the player to remove the buys from
	--count: the amount of buys to remove
	return Duel.GetCounterHolder(player):RemoveCounter(player,COUNTER_BUYS,count,REASON_RULE)
end
--decrease a player's coins
function Duel.RemoveCoin(player,count)
	--player: the player to remove the coins from
	--count: the amount of coins to remove
	return Duel.GetCounterHolder(player):RemoveCounter(player,COUNTER_COINS,count,REASON_RULE)
end
--get the amount of actions a player has
function Duel.GetActions(player)
	return Duel.GetCounterHolder(player):GetCounter(COUNTER_ACTIONS)
end
--get the amount of buys a player has
function Duel.GetBuys(player)
	return Duel.GetCounterHolder(player):GetCounter(COUNTER_BUYS)
end
--get the amount of coins a player has
function Duel.GetCoins(player)
	return Duel.GetCounterHolder(player):GetCounter(COUNTER_COINS)
end
--check if a player can play an action card
function Duel.IsPlayerCanPlayAction(player)
	if Duel.GetTurnPlayer()~=player or Duel.GetCurrentPhase()~=PHASE_ACTION then return false end
	return Duel.GetActions(player)>0
end
--check if a player can play a treasure card
function Duel.IsPlayerCanBuy(player)
	if Duel.GetTurnPlayer()~=player or Duel.GetCurrentPhase()~=PHASE_BUY then return false end
	return Duel.GetBuys(player)>0
end
--get the total amount of coins a player has
function Duel.GetCoin(player)
	local g=Duel.GetMatchingGroup(aux.InPlayFilter(Card.IsType),player,LOCATION_INPLAY,0,nil,TYPE_TREASURE)
	return g:GetSum(Card.GetCoin)
end
--get the total amount of victory points a player has
function Duel.GetVP(player)
	local g=Duel.GetMatchingGroup(Card.IsHasVP,player,LOCATION_ALL-LOCATION_SUPPLY,0,nil)
	return g:GetSum(Card.GetVP)
end
--move a card to the in play area when it is played
function Duel.SendtoInPlay(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	for tc in aux.Next(targets) do
		--check for "You may play an Action card from your hand twice" (Throne Room 1-024)
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAIN_SOLVED)
		e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			local c=e:GetHandler()
			if c:IsHasEffect(EFFECT_PLAY_ACTION_TWICE) then
				Duel.PlayAction(c)
			end
		end)
		e1:SetReset(RESET_EVENT+RESET_CHAIN)
		Duel.RegisterEffect(e1,tc:GetControler())
	end
	return Duel.Remove(targets,POS_FACEUP,reason,tc:GetControler())
end
--gain a card
function Duel.GainCards(targets,reason,player,dest_loc)
	--dest_loc: where to put the gained card (discard pile by default)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		if tc:GetCounter(COUNTER_COPIES)>1 then
			local card=Duel.CreateCard(player,tc:GetCode())
			if dest_loc==LOCATION_DECK then
				Duel.SendtoDeck(card,player,SEQ_DECK_SHUFFLE,reason)
				Duel.ShuffleDeck(player)
			elseif dest_loc==LOCATION_HAND then
				Duel.SendtoHand(card,player,reason)
				Duel.ConfirmCards(1-player,card)
				Duel.ShuffleHand(player)
			else
				Duel.SendtoDPile(card,reason,player)
			end
			tc:RemoveCounter(player,COUNTER_COPIES,1,REASON_RULE)
		else
			if dest_loc==LOCATION_DECK then
				Duel.SendtoDeck(tc,player,SEQ_DECK_SHUFFLE,reason)
				Duel.ShuffleDeck(player)
			elseif dest_loc==LOCATION_HAND then
				Duel.SendtoHand(tc,player,reason)
				Duel.ConfirmCards(1-player,tc)
				Duel.ShuffleHand(player)
			else
				Duel.SendtoDPile(tc,reason,player)
			end
			--remove kingdom card status
			tc:SetStatus(STATUS_KINGDOM,false)
		end
		res=res+1
	end
	return res
end
--trash a card
function Duel.Trash(targets,reason,player)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		--trash a card when it is put in play (e.g. "Feast" 1-016)
		if tc:GetDestination()==LOCATION_INPLAY then
			Duel.DisableShuffleCheck()
			Duel.SendtoHand(tc,player,REASON_RULE)
		end
		res=res+Duel.Remove(tc,POS_FACEUP,reason+REASON_TRASH,player)
	end
	return res
end
--get the number of cards a player has
function Duel.GetCardCount(player)
	return Duel.GetFieldGroupCount(player,LOCATION_HAND+LOCATION_DECK+LOCATION_DPILE+LOCATION_TRASH,0)
end
--play an action card
function Duel.PlayAction(targets)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		Duel.DisableShuffleCheck(true)
		Duel.SendtoHand(tc,tc:GetControler(),REASON_RULE)
		Duel.ConfirmCards(1-tc:GetControler(),tc)
		Duel.RaiseSingleEvent(tc,EVENT_CUSTOM+EVENT_PLAY_ACTION,tc:GetReasonEffect(),0,0,0,0)
		Duel.DisableShuffleCheck(false)
		res=res+1
	end
	return res
end
--check if there is a province pile
function Duel.CheckProvincePile()
	return Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsCode),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,CARD_PROVINCE)
end
--get the number of empty supply piles
function Duel.GetEmptySupplyPiles()
	local ct=Duel.GetMatchingGroupCount(aux.SupplyFilter(),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil)
	return 17-ct
end
--Renamed Duel functions
--send a card to the discard pile
Duel.SendtoDPile=Duel.SendtoGrave
