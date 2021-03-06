--Overwritten Duel functions
--get the default number of cards a player draws during the clean-up phase
--Note: Do not use EFFECT_DRAW_COUNT, to avoid issues with Rule.cannot_draw
local duel_get_draw_count=Duel.GetDrawCount
function Duel.GetDrawCount(player)
	local res=5
	local t={Duel.IsPlayerAffectedByEffect(player,EFFECT_CHANGE_DRAW_COUNT)}
	for _,te in pairs(t) do
		if type(te:GetValue())=="function" then
			res=te:GetValue()(te,c)
		else
			res=te:GetValue()
		end
	end
	return res
end
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
--sort the top cards of a player's deck
--Note: Overwritten to only let a player sort cards if there are more than 1
local duel_sort_decktop=Duel.SortDecktop
function Duel.SortDecktop(sort_player,target_player,count)
	if count>1 then
		return duel_sort_decktop(sort_player,target_player,count)
	else
		return nil
	end
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
--get the bottom cards of a player's deck
function Duel.GetDeckbottomGroup(player,count)
	local f=function(c,count)
		local seq=c:GetSequence()
		return seq>=0 and seq<=count-1
	end
	return Duel.GetMatchingGroup(f,player,LOCATION_DECK,0,nil,count)
end
--get the operated card
function Duel.GetOperatedCard()
	return Duel.GetOperatedGroup():GetFirst()
end
--generate a card
function Duel.CreateCard(player,code)
	--player: the player who generates the card
	--code: the id of the card to generate
	return Duel.CreateToken(player,code)
end
--generate a random number
--With no arguments, returns a random number in the range [0, 1]. That is, zero up to but excluding 1.
--With 1 argument, returns an integer in the range [1, n]. That is from 1 up to and including n.
--With 2 arguments, returns an integer in the range [n, u]. That is from n up to and including u.
function Duel.GetRandomNumber(n,u)
	local os=require('os')
	math.randomseed(os.time())
	return math.random(n,u)
end
--get a player's counter holder (not available in the official game)
function Duel.GetCounterHolder(player)
	return Duel.GetFirstMatchingCard(Card.IsCode,player,LOCATION_SUPPLY,0,nil,CARD_COUNTER_HOLDER)
end
--increase a player's actions
function Duel.AddAction(player,count)
	--player: the player whose actions to increase
	--count: the amount of actions to add
	return Duel.GetCounterHolder(player):AddCounter(COUNTER_ACTIONS,count)
end
--increase a player's buys
function Duel.AddBuy(player,count)
	--player: the player whose buys to increase
	--count: the amount of buys to add
	return Duel.GetCounterHolder(player):AddCounter(COUNTER_BUYS,count)
end
--increase a player's coins
function Duel.AddCoin(player,count)
	--player: the player whose coins to increase
	--count: the amount of coins to add
	return Duel.GetCounterHolder(player):AddCounter(COUNTER_COINS,count)
end
--increase a player's potions
function Duel.AddPotion(player,count)
	--player: the player whose potions to increase
	--count: the amount of potions to add
	return Duel.GetCounterHolder(player):AddCounter(COUNTER_POTIONS,count)
end
--decrease a player's actions
function Duel.RemoveAction(player,count)
	--player: the player whose actions to decrease
	--count: the amount of actions to remove
	return Duel.GetCounterHolder(player):RemoveCounter(player,COUNTER_ACTIONS,count,REASON_RULE)
end
--decrease a player's buys
function Duel.RemoveBuy(player,count)
	--player: the player whose buys to decrease
	--count: the amount of buys to remove
	return Duel.GetCounterHolder(player):RemoveCounter(player,COUNTER_BUYS,count,REASON_RULE)
end
--decrease a player's coins
function Duel.RemoveCoin(player,count)
	--player: the player whose coins to decrease
	--count: the amount of coins to remove
	return Duel.GetCounterHolder(player):RemoveCounter(player,COUNTER_COINS,count,REASON_RULE)
end
--decrease a player's potions
function Duel.RemovePotion(player,count)
	--player: the player whose potions to decrease
	--count: the amount of potions to remove
	return Duel.GetCounterHolder(player):RemoveCounter(player,COUNTER_POTIONS,count,REASON_RULE)
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
--get the amount of potions a player has
function Duel.GetPotions(player)
	return Duel.GetCounterHolder(player):GetCounter(COUNTER_POTIONS)
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
--check if a player can trash the top cards of a deck
function Duel.IsPlayerCanTrashDeck(player,count)
	local g=Duel.GetDecktopGroup(player,count)
	return g:FilterCount(Card.IsAbleToTrash,nil)>0
end
--check if potion rules are applied
function Duel.CheckPotionRules()
	local res=false
	if Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsCode),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,CARD_POTION) then
		res=true
	end
	return res
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
	local ct4=Duel.GetPotions(turnp)
	if ct1>0 then Duel.RemoveAction(turnp,ct1) end
	if ct2>0 then Duel.RemoveBuy(turnp,ct2) end
	if ct3>0 then Duel.RemoveCoin(turnp,ct3) end
	if ct4>0 then Duel.RemovePotion(turnp,ct4) end
end
--get all cards a player has
function Duel.GetAllCards(player)
	local s1=LOCATION_ALL-LOCATION_SUPPLY
	local o1=player and 0 or s1
	local s2=LOCATION_TRASH
	local o2=player and 0 or s2
	local player=player or 0
	local g=Duel.GetMatchingGroup(nil,player,s1,o1,nil)
	local sg=Duel.GetMatchingGroup(aux.TrashFilter(),player,s2,o2,nil)
	g:Sub(sg)
	return g
end
--get the number of cards a player has
function Duel.GetCardCount(player)
	local g=Duel.GetAllCards(player)
	return g:GetCount()
end
--get the total amount of victory points a player has
function Duel.GetVP(player)
	local g=Duel.GetAllCards(player)
	return g:GetSum(Card.GetVP)+Duel.GetTokens(player,COUNTER_VP_TOKEN)
end
--check if there is a province pile
function Duel.CheckProvincePile()
	return Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsCode),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,CARD_PROVINCE,CARD_COLONY)
end
--get the number of empty supply piles
function Duel.GetEmptySupplyPiles()
	local MAX_SUPPLY_PILES=17
	if Duel.CheckPotionRules() then
		MAX_SUPPLY_PILES=18
	end
	return MAX_SUPPLY_PILES-Duel.GetMatchingGroupCount(aux.SupplyFilter(),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil)
end
--send a card to the in play area when it is played
function Duel.SendtoInPlay(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local tc=targets:GetFirst()
	for tc in aux.Next(targets) do
		--check for "You may play an Action card from your hand N times" ("Throne Room" 1-024, "King's Court" 5-026)
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAIN_SOLVED)
		e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			local count=0
			local c=e:GetHandler()
			count=count+(c:GetEffectCount(EFFECT_PLAY_ACTION_TWICE)*1)
			count=count+(c:GetEffectCount(EFFECT_PLAY_ACTION_THRICE)*2)
			for i=1,count do
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
	if not targets then return res end
	--check if a card can be bought
	if bit.band(reason,REASON_BUY)~=0 then
		targets=targets:Filter(Card.IsCanBeBought,nil)
	end
	for tc in aux.Next(targets) do
		if tc:GetCounter(COUNTER_COPIES)>1 then
			local card=Duel.CreateCard(player,tc:GetCode())
			if dest_loc==LOCATION_DECK then
				Duel.SendtoDeck(card,player,SEQ_DECK_TOP,reason)
				Duel.ConfirmDecktop(player,1)
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
				Duel.SendtoDeck(tc,player,SEQ_DECK_TOP,reason)
				Duel.ConfirmDecktop(player,1)
			elseif dest_loc==LOCATION_HAND then
				Duel.SendtoHand(tc,player,reason)
				Duel.ConfirmCards(1-player,tc)
				Duel.ShuffleHand(player)
			else
				Duel.SendtoDPile(tc,reason,player)
			end
		end
		--remove kingdom card status
		tc:SetStatus(STATUS_KINGDOM,false)
		--raise event for gaining cards
		Duel.RaiseEvent(tc,EVENT_CUSTOM+EVENT_GAIN,Effect.GlobalEffect(),0,player,player,0)
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
		--check if a card is in the supply
		if tc:IsLocation(LOCATION_SUPPLY) and tc:GetCounter(COUNTER_COPIES)>1 then
			tc=Duel.CreateCard(player,tc:GetCode())
			tc:RemoveCounter(player,COUNTER_COPIES,1,REASON_RULE)
		end
		res=res+Duel.Remove(tc,POS_FACEUP,reason+REASON_TRASH,player)
		--remove kingdom card status
		tc:SetStatus(STATUS_KINGDOM,false)
	end
	return res
end
--trash the top cards of a player's deck
function Duel.TrashDeck(player,count,reason)
	local res=0
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	local g1=Duel.GetMatchingGroup(Card.IsAbleToDeck,player,LOCATION_DPILE,0,nil)
	if count>deck_count and g1:GetCount()>0 then
		Duel.SendtoDeck(g1,player,SEQ_DECK_SHUFFLE,REASON_RULE)
		Duel.ShuffleDeck(player)
	end
	if deck_count>0 and count>deck_count and g1:GetCount()==0 then count=deck_count end
	--fix some cards sent to the wrong player's trash pile
	if Duel.IsPlayerCanTrashDeck(player,count) then
		local g2=Duel.GetDecktopGroup(player,count)
		Duel.DisableShuffleCheck()
		res=res+Duel.Trash(g2,reason,player)
	end
	return res
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
--play a treasure card
function Duel.PlayTreasure(targets)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		Duel.DisableShuffleCheck(true)
		Duel.SendtoHand(tc,tc:GetControler(),REASON_RULE)
		Duel.ConfirmCards(1-tc:GetControler(),tc)
		Duel.RaiseSingleEvent(tc,EVENT_CUSTOM+EVENT_PLAY_TREASURE,tc:GetReasonEffect(),0,0,0,0)
		Duel.DisableShuffleCheck(false)
		res=res+1
	end
	return res
end
--add a token to a supply pile
function Duel.AddSupplyToken(targets,tokentype,count)
	--targets: the supply pile to add the token to
	--tokentype: the name of the token
	--count: the number of tokens to add
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=false
	for tc in aux.Next(targets) do
		res=tc:AddCounter(tokentype,count)
		--register the effect of "Embargo" (3-001)
		if tokentype==COUNTER_EMBARGO_TOKEN then
			local e1=Effect.GlobalEffect()
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_ADJUST)
			e1:SetCountLimit(count)
			e1:SetLabelObject(tc)
			e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetLabelObject()
				local g=Duel.GetMatchingGroup(Card.IsCode,0,LOCATION_ALL,LOCATION_ALL,nil,c:GetCode())
				for tc in aux.Next(g) do
					local e1=Effect.CreateEffect(c)
					e1:SetType(EFFECT_TYPE_SINGLE)
					e1:SetCode(EFFECT_EMBARGO)
					tc:RegisterEffect(e1)
				end
			end)
			Duel.RegisterEffect(e1,0)
		end
	end
	return res
end
--add a token to a player
function Duel.AddPlayerToken(player,tokentype,count)
	--player: the player to add the token to
	--tokentype: the name of the token
	--count: the number of tokens to add
	return Duel.GetCounterHolder(player):AddCounter(tokentype,count)
end
--get the number of tokens a player has
function Duel.GetTokens(player,tokentype)
	return Duel.GetCounterHolder(player):GetCounter(tokentype)
end
--set aside a card
function Duel.SetAside(targets,pos,reason,player)
	return Duel.Remove(targets,pos,reason,player)
end
--send a card to the supply
function Duel.SendtoSupply(targets)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc1 in aux.Next(targets) do
		local tc2=Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsCode),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,tc1:GetCode())
		if tc2 then
			Duel.SendtoDeck(tc1,PLAYER_OWNER,SEQ_DECK_UNEXIST,REASON_RULE)
			tc2:AddCounter(COUNTER_COPIES,1)
		else
			if Duel.GetLocationCount(PLAYER_ONE,LOCATION_MZONE)>0 then
				Duel.MoveToField(tc1,PLAYER_ONE,PLAYER_ONE,LOCATION_MZONE,POS_FACEUP_ATTACK,true)
			else
				Duel.MoveToField(tc1,PLAYER_ONE,PLAYER_ONE,LOCATION_SZONE,POS_FACEUP,true)
			end
			tc1:AddCounter(COUNTER_COPIES,1)
		end
		res=res+1
	end
	return res
end
--Renamed Duel functions
--get a player's score
Duel.GetScore=Duel.GetLP
--set a player's score
Duel.SetScore=Duel.SetLP
--send a card to the discard pile
Duel.SendtoDPile=Duel.SendtoGrave
