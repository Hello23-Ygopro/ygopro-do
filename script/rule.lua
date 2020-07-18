Rule={}
--register rules
function Rule.RegisterRules(c)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_NO_TURN_RESET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_ALL)
	e1:SetCountLimit(1)
	e1:SetOperation(Rule.ApplyRules)
	c:RegisterEffect(e1)
end
function Rule.ApplyRules(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(PLAYER_ONE,10000000)>0 then return end
	Duel.RegisterFlagEffect(PLAYER_ONE,10000000,0,0,0)
	--remove rules
	Rule.remove_rules()
	--create starting deck
	Rule.create_starting_deck(PLAYER_ONE)
	Rule.create_starting_deck(PLAYER_TWO)
	--set up kingdom cards
	Rule.setup_kingdom_cards()
	--set up base cards
	Rule.setup_base_cards()
	--add copies
	Rule.add_copies()
	--draw starting hand
	Duel.Draw(PLAYER_ONE,5,REASON_RULE)
	Duel.Draw(PLAYER_TWO,5,REASON_RULE)
	--set lp
	Duel.SetLP(PLAYER_ONE,1)
	Duel.SetLP(PLAYER_TWO,1)
	--start turn
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_ACTION)
	e1:SetCountLimit(1)
	e1:SetOperation(Rule.StartTurnOperation)
	Duel.RegisterEffect(e1,0)
	--put in play
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAINING)
	e2:SetOperation(Rule.PutInPlayOperation)
	Duel.RegisterEffect(e2,0)
	--limit actions
	local e3=Effect.GlobalEffect()
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetTargetRange(1,0)
	e3:SetCondition(Rule.LimitActionCondition1)
	e3:SetValue(Rule.LimitAction)
	Duel.RegisterEffect(e3,0)
	local e4=e3:Clone()
	e4:SetTargetRange(0,1)
	e4:SetCondition(Rule.LimitActionCondition2)
	Duel.RegisterEffect(e4,0)
	--limit buys
	local e5=Effect.GlobalEffect()
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_ACTIVATE)
	e5:SetTargetRange(1,0)
	e5:SetCondition(Rule.LimitBuyCondition1)
	e5:SetValue(Rule.LimitBuy)
	Duel.RegisterEffect(e5,0)
	local e6=e5:Clone()
	e6:SetTargetRange(0,1)
	e6:SetCondition(Rule.LimitBuyCondition2)
	Duel.RegisterEffect(e6,0)
	--clean-up phase
	local e7=Effect.GlobalEffect()
	e7:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EVENT_PHASE_START+PHASE_CLEANUP)
	e7:SetCountLimit(1)
	e7:SetOperation(Rule.CleanupOperation)
	Duel.RegisterEffect(e7,0)
	--end game
	local e8=Effect.GlobalEffect()
	e8:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_TURN_END)
	e8:SetCountLimit(1)
	e8:SetCondition(Rule.EndGameCondition)
	e8:SetOperation(Rule.EndGameOperation)
	Duel.RegisterEffect(e8,0)
	--override yugioh rules
	--cannot draw
	Rule.cannot_draw()
	--cannot summon
	Rule.cannot_summon()
	--cannot mset
	Rule.cannot_mset()
	--cannot sset
	Rule.cannot_sset()
	--infinite hand
	Rule.infinite_hand()
	--cannot conduct phases
	Rule.cannot_phases()
	--cannot change position
	Rule.cannot_change_position()
	--cannot lose
	Rule.cannot_lose()
end
--remove rules
function Rule.remove_rules()
	local g=Duel.GetMatchingGroup(aux.TRUE,0,LOCATION_ALL,LOCATION_ALL,nil)
	if g:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_UNEXIST,REASON_RULE)
	end
	--add card to keep track of actions, buys and coins
	local c1=Duel.CreateCard(PLAYER_ONE,CARD_COUNTER_HOLDER)
	local c2=Duel.CreateCard(PLAYER_TWO,CARD_COUNTER_HOLDER)
	Duel.MoveToField(c1,PLAYER_ONE,PLAYER_ONE,LOCATION_SZONE,POS_FACEUP,true)
	Duel.MoveToField(c2,PLAYER_ONE,PLAYER_TWO,LOCATION_SZONE,POS_FACEUP,true)
end
--create starting deck
function Rule.create_starting_deck(tp)
	local g=Group.CreateGroup()
	for i=1,3 do
		g:AddCard(Duel.CreateCard(tp,CARD_ESTATE))
	end
	for i=1,7 do
		g:AddCard(Duel.CreateCard(tp,CARD_COPPER))
	end
	Duel.SendtoDeck(g,tp,SEQ_DECK_SHUFFLE,REASON_RULE)
	Duel.ShuffleDeck(tp)
end
--set up kingdom cards
kingdom_card_list={}
kingdom_card_list["Base"]={
	10001008,10001009,10001010,10001011,10001012,10001013,10001014,10001015,10001016,10001017,
	10001018,10001019,10001020,10001021,10001022,10001023,10001024,10001025,10001026,10001027,
	10001028,10001029,10001030,10001031,10001032,10001033,10001034,10001035,10001036,10001037,
	10001038,10001039
}
function Rule.setup_kingdom_cards()
	local os=require('os')
	math.randomseed(os.time())
	local t=kingdom_card_list["Base"]
	for i=1,10 do
		local random=math.random(#t)
		local code=t[random]
		local card=Duel.CreateCard(PLAYER_ONE,code)
		Duel.SendtoDeck(card,PLAYER_ONE,SEQ_DECK_TOP,REASON_RULE)
		--add kingdom card status
		card:SetStatus(STATUS_KINGDOM,true)
		table.remove(t,random)
	end
	local mzone=0x1
	local szone=0x1
	local g=Duel.GetMatchingGroup(Card.IsStatus,PLAYER_ONE,LOCATION_DECK,0,nil,STATUS_KINGDOM)
	for c in aux.Next(g) do
		if mzone<0x20 then
			Duel.MoveToField(c,PLAYER_ONE,PLAYER_ONE,LOCATION_MZONE,POS_FACEUP_ATTACK,true,mzone)
		else
			Duel.MoveToField(c,PLAYER_ONE,PLAYER_ONE,LOCATION_SZONE,POS_FACEUP,true,szone)
			szone=szone+szone
		end
		mzone=mzone+mzone
	end
end
--set up base cards
function Rule.setup_base_cards()
	local card1=Duel.CreateCard(PLAYER_TWO,CARD_COPPER)
	local card2=Duel.CreateCard(PLAYER_TWO,CARD_SILVER)
	local card3=Duel.CreateCard(PLAYER_TWO,CARD_GOLD)
	local card4=Duel.CreateCard(PLAYER_TWO,CARD_ESTATE)
	local card5=Duel.CreateCard(PLAYER_TWO,CARD_DUCHY)
	local card6=Duel.CreateCard(PLAYER_TWO,CARD_PROVINCE)
	local card7=Duel.CreateCard(PLAYER_TWO,CARD_CURSE)
	Duel.MoveToField(card1,PLAYER_ONE,PLAYER_TWO,LOCATION_MZONE,POS_FACEUP_ATTACK,true,ZONE_COPPER)
	Duel.MoveToField(card2,PLAYER_ONE,PLAYER_TWO,LOCATION_MZONE,POS_FACEUP_ATTACK,true,ZONE_SILVER)
	Duel.MoveToField(card3,PLAYER_ONE,PLAYER_TWO,LOCATION_MZONE,POS_FACEUP_ATTACK,true,ZONE_GOLD)
	Duel.MoveToField(card4,PLAYER_ONE,PLAYER_TWO,LOCATION_SZONE,POS_FACEUP,true,ZONE_ESTATE)
	Duel.MoveToField(card5,PLAYER_ONE,PLAYER_TWO,LOCATION_SZONE,POS_FACEUP,true,ZONE_DUCHY)
	Duel.MoveToField(card6,PLAYER_ONE,PLAYER_TWO,LOCATION_SZONE,POS_FACEUP,true,ZONE_PROVINCE)
	Duel.MoveToField(card7,PLAYER_ONE,PLAYER_TWO,LOCATION_SZONE,POS_FACEUP,true,ZONE_CURSE)
end
--add copies
function Rule.add_copies()
	local g=Duel.GetMatchingGroup(aux.SupplyFilter(),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil)
	for c in aux.Next(g) do
		if c:IsType(TYPE_VICTORY) then c:AddCounter(COUNTER_COPIES,8)
		else
			if c:IsCode(CARD_COPPER) then c:AddCounter(COUNTER_COPIES,46)
			elseif c:IsCode(CARD_SILVER) then c:AddCounter(COUNTER_COPIES,40)
			elseif c:IsCode(CARD_GOLD) then c:AddCounter(COUNTER_COPIES,30)
			elseif c:IsStatus(STATUS_KINGDOM) or c:IsType(TYPE_CURSE) then c:AddCounter(COUNTER_COPIES,10) end
		end
	end
end
--start turn
function Rule.StartTurnOperation(e,tp,eg,ep,ev,re,r,rp)
	local turnp=Duel.GetTurnPlayer()
	Duel.AddAction(turnp,1)
	Duel.AddBuy(turnp,1)
	Duel.AddCoin(turnp,0)
end
--put in play
function Rule.PutInPlayOperation(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	local cp=rc:GetControler()
	if rc:IsType(TYPE_ACTION) then
		if re:IsHasProperty(EFFECT_FLAG_PLAY_PARAM) then
			Duel.RemoveAction(cp,1)
		end
		Duel.SendtoInPlay(rc,REASON_RULE)
	elseif rc:IsType(TYPE_TREASURE) then
		local g=Duel.GetMatchingGroup(Card.IsType,cp,LOCATION_HAND,0,nil,TYPE_TREASURE)
		Duel.SendtoInPlay(g,REASON_RULE)
		local coin=g:GetSum(Card.GetCoin)
		Duel.AddCoin(cp,coin)
	end
end
--limit actions
function Rule.LimitActionCondition1(e)
	return not Duel.IsPlayerCanPlayAction(e:GetHandlerPlayer())
end
function Rule.LimitActionCondition2(e)
	return not Duel.IsPlayerCanPlayAction(1-e:GetHandlerPlayer())
end
function Rule.LimitAction(e,re,tp)
	local rc=re:GetHandler()
	return re:IsHasProperty(EFFECT_FLAG_PLAY_PARAM) and rc:IsType(TYPE_ACTION)
		--check for "You may play an Action card from your hand twice" (Throne Room 1-024)
		and not rc:IsHasEffect(EFFECT_PLAY_ACTION_TWICE)
end
--limit buys
function Rule.LimitBuyCondition1(e)
	return not Duel.IsPlayerCanBuy(e:GetHandlerPlayer())
end
function Rule.LimitBuyCondition2(e)
	return not Duel.IsPlayerCanBuy(1-e:GetHandlerPlayer())
end
function Rule.LimitBuy(e,re,tp)
	local rc=re:GetHandler()
	return re:IsHasProperty(EFFECT_FLAG_PLAY_PARAM) and rc:IsType(TYPE_TREASURE)
end
--clean-up phase
function Rule.CleanupOperation(e,tp,eg,ep,ev,re,r,rp)
	local turnp=Duel.GetTurnPlayer()
	local g1=Duel.GetMatchingGroup(aux.InPlayFilter(Card.IsAbleToDPile),turnp,LOCATION_INPLAY,0,nil)
	local g2=Duel.GetMatchingGroup(Card.IsAbleToDPile,turnp,LOCATION_HAND,0,nil)
	g1:Merge(g2)
	Duel.SendtoDPile(g1,REASON_RULE,turnp)
	Duel.Draw(turnp,5,REASON_RULE)
	Duel.EndTurn()
end
--end game
function Rule.EndGameCondition(e)
	return not Duel.CheckProvincePile() or Duel.GetEmptySupplyPiles()>=3
end
function Rule.EndGameOperation(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(aux.TRUE,PLAYER_ONE,LOCATION_ALL-LOCATION_DECK-LOCATION_SUPPLY,0,nil)
	local g2=Duel.GetMatchingGroup(aux.TRUE,PLAYER_TWO,LOCATION_ALL-LOCATION_DECK-LOCATION_SUPPLY,0,nil)
	Duel.SendtoDeck(g1,PLAYER_ONE,SEQ_DECK_SHUFFLE,REASON_RULE)
	Duel.SendtoDeck(g2,PLAYER_TWO,SEQ_DECK_SHUFFLE,REASON_RULE)
	local g3=Duel.GetMatchingGroup(Card.IsHasVP,PLAYER_ONE,LOCATION_DECK,0,nil)
	local g4=Duel.GetMatchingGroup(Card.IsHasVP,PLAYER_TWO,LOCATION_DECK,0,nil)
	Duel.DisableShuffleCheck()
	Duel.SendtoHand(g3,PLAYER_ONE,REASON_RULE)
	Duel.ConfirmCards(PLAYER_TWO,g3)
	Duel.SendtoHand(g4,PLAYER_TWO,REASON_RULE)
	Duel.ConfirmCards(PLAYER_ONE,g4)
	local ct1=Duel.GetVP(PLAYER_ONE)
	Duel.SetLP(PLAYER_ONE,ct1)
	local ct2=Duel.GetVP(PLAYER_TWO)
	Duel.SetLP(PLAYER_TWO,ct2)
	if ct1>ct2 then
		Duel.Win(PLAYER_ONE,WIN_REASON_VP)
	elseif ct1<ct2 then
		Duel.Win(PLAYER_TWO,WIN_REASON_VP)
	elseif ct1==ct2 then
		Duel.Win(PLAYER_NONE,WIN_REASON_VP)
	end
end
--override yugioh rules
--cannot draw
function Rule.cannot_draw()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DRAW_COUNT)
	e1:SetTargetRange(1,1)
	e1:SetValue(0)
	Duel.RegisterEffect(e1,0)
end
--cannot summon
function Rule.cannot_summon()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
end
--cannot mset
function Rule.cannot_mset()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_MSET)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
end
--cannot sset
function Rule.cannot_sset()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SSET)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
end
--infinite hand
function Rule.infinite_hand()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_HAND_LIMIT)
	e1:SetTargetRange(1,1)
	e1:SetValue(MAX_NUMBER)
	Duel.RegisterEffect(e1,0)
end
--cannot conduct phases
function Rule.cannot_phases()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_M2)
	Duel.RegisterEffect(e2,0)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_EP)
	Duel.RegisterEffect(e3,0)
end
--cannot change position
function Rule.cannot_change_position()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	Duel.RegisterEffect(e1,0)
end
--cannot lose
function Rule.cannot_lose()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_LOSE_DECK)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
end
