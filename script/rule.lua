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
	--start turn
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_ACTION)
	e1:SetCountLimit(1)
	e1:SetOperation(Rule.StartTurnOperation)
	Duel.RegisterEffect(e1,0)
	--put in play
	local e2=Effect.GlobalEffect()
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
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
	--show score
	local e8=Effect.GlobalEffect()
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_ADJUST)
	e8:SetOperation(Rule.ShowScoreOperation)
	Duel.RegisterEffect(e8,0)
	--end game
	local e9=Effect.GlobalEffect()
	e9:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e9:SetCode(EVENT_TURN_END)
	e9:SetCountLimit(1)
	e9:SetCondition(Rule.EndGameCondition)
	e9:SetOperation(Rule.EndGameOperation)
	Duel.RegisterEffect(e9,0)
	--override yugioh rules
	--set level status
	Rule.set_level_status()
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
	--excluded basic cards: 10001001-10001007 (Copper, Curse, Estate, Silver, Duchy, Gold, Province)
	10001008,10001009,10001010,10001011,10001012,10001013,10001014,10001015,10001016,10001017,
	10001018,10001019,10001020,10001021,10001022,10001023,10001024,10001025,10001026,10001027,
	10001028,10001029,10001030,10001031,10001032,10001033,10001034,10001035,10001036,10001037,
	10001038,10001039
}
kingdom_card_list["Intrigue"]={
	10002001,10002002,10002003,10002004,10002005,10002006,10002007,10002008,10002009,10002010,
	10002011,10002012,10002013,10002014,10002015,10002016,10002017,10002018,10002019,10002020,
	10002021,10002022,10002023,10002024,10002025,10002026,10002027,10002028,10002029,10002030,
	10002031,10002032
}
kingdom_card_list["Seaside"]={
	10003001,10003002,--[[10003003,]]--[[10003004,]]10003005,10003006,10003007,10003008,10003009,10003010,
	10003011,10003012,--[[10003013,]]10003014,--[[10003015,]]10003016,10003017,10003018,10003019,10003020,
	10003021,10003022,10003023,10003024,10003025,10003026
}
kingdom_card_list["Alchemy"]={
	--excluded basic cards: 10004001 (Potion)
	10004002,10004003,10004004,10004005,10004006,10004007,10004008,10004009,10004010,10004011,
	10004012,--10004013
}
kingdom_card_list["Prosperity"]={
	--excluded basic cards: 10005001-10005002 (Platinum, Colony)
	10005003,10005004,10005005,10005006,10005007,10005008,10005009,10005010,10005011,10005012,
	10005013,10005014,10005015,10005016,10005017,10005018,10005019,10005020,10005021,10005022,
	10005023,10005024,10005025,10005026,10005027
}
kingdom_card_list["Cornucopia"]={
	--excluded prize cards: 10006014-10006018 (Bag of Gold, Diadem, Followers, Princess, Trusty Steed)
	10006001,10006002,10006003,10006004,10006005,10006006,10006007,10006008,10006009,10006010,
	10006011,10006012,10006013
}
kingdom_card_list["Hinterlands"]={
	10007001,10007002,10007003,10007004,10007005,10007006,10007007,10007008,10007009,10007010,
	10007011,10007012,10007013,10007014,10007015,10007016,10007017,10007018,10007019,10007020,
	10007021,10007022,10007023,10007024,10007025,10007026
}
kingdom_card_list["Dark Ages"]={
	--excluded ruin cards: 10008046-10008050 (Abandoned Mine - Survivors)
	--excluded shelter cards: 10008051-10008053 (Hovel, Necropolis, Overgrown Estate)
	--excluded non-supply cards: 10008054-10008056 (Madman, Mercenary, Spoils)
	10008001,10008002,10008003,10008004,10008005,10008006,10008007,10008008,10008009,10008010,
	10008011,10008012,10008013,10008014,10008015,10008016,10008017,10008018,10008019,10008020,
	10008021,10008022,10008023,10008024,10008025,10008026,10008027,10008028,10008029,10008030,
	10008031,10008032,10008033,10008034,10008035,10008036,10008037,10008038,10008039,10008040,
	10008041,10008042,10008043,10008044,10008045
}
kingdom_card_list["Guilds"]={
	10009001,10009002,10009003,10009004,10009005,10009006,10009007,10009008,10009009,10009010,
	10009011,10009012,10009013
}
kingdom_card_list["Adventures"]={
	--excluded event cards: 10010039-10010058 (Alms - Pathfinding)
	10010001,10010002,10010003,10010004,10010005,10010006,10010007,10010008,10010009,10010010,
	10010011,10010012,10010013,10010014,10010015,10010016,10010017,10010018,10010019,10010020,
	10010021,10010022,10010023,10010024,10010025,10010026,10010027,10010028,10010029,10010030,
	10010031,10010032,10010033,10010034,10010035,10010036,10010037,10010038
}
kingdom_card_list["Empires"]={
	--excluded event cards: 10011038-10011050 (Triumph - Dominate)
	--excluded landmark cards: 10011051-10011071 (Aqueduct - Wolf Den)
	10011001,10011002,10011003,10011004,10011005,10011006,10011007,10011008,10011009,10011010,
	10011011,10011012,10011013,10011014,10011015,10011016,10011017,10011018,10011019,10011020,
	10011021,10011022,10011023,10011024,10011025,10011026,10011027,10011028,10011029,10011030,
	10011031,10011032,10011033,10011034,10011035,10011036,10011037
}
kingdom_card_list["Nocturne"]={
	--excluded non-supply cards: 10012034-10012048 (Haunted Mirror - Ghost)
	--excluded boons: 10012049-10012060 (The Earth's Gift - The Wind's Gift)
	--excluded hexes: 10012061-10012072 (Bad Omens - War)
	--excluded states: 10012073-10012077 (Deluded - Lost in the Woods)
	10012001,10012002,10012003,10012004,10012005,10012006,10012007,10012008,10012009,10012010,
	10012011,10012012,10012013,10012014,10012015,10012016,10012017,10012018,10012019,10012020,
	10012021,10012022,10012023,10012024,10012025,10012026,10012027,10012028,10012029,10012030,
	10012031,10012032,10012033
}
kingdom_card_list["Renaissance"]={
	--excluded artifacts: 10013026-10013030 (Flag, Horn, Key, Lantern, Treasure Chest)
	--excluded project cards: 10013031-10013050 (Cathedral - Citadel)
	10013001,10013002,10013003,10013004,10013005,10013006,10013007,10013008,10013009,10013010,
	10013011,10013012,10013013,10013014,10013015,10013016,10013017,10013018,10013019,10013020,
	10013021,10013022,10013023,10013024,10013025
}
Rule.platinum=false
Rule.colony=false
function Rule.setup_kingdom_cards()
	--choose a card set
	local card_list={}
	local sel_list={0x1,0x2,0x4,0x8,0x10}
	local option_list={OPTION_BASE,OPTION_INTRIGUE,OPTION_SEASIDE,OPTION_ALCHEMY,OPTION_PROSPERITY}
	Duel.Hint(HINT_SELECTMSG,PLAYER_ONE,HINTMSG_CHOOSESET)
	local opt=Duel.SelectOption(PLAYER_ONE,table.unpack(option_list))+1
	local sel=sel_list[opt]
	if bit.band(sel,0x1)~=0 then
		card_list=kingdom_card_list["Base"]
	end
	if bit.band(sel,0x2)~=0 then
		card_list=kingdom_card_list["Intrigue"]
	end
	if bit.band(sel,0x4)~=0 then
		card_list=kingdom_card_list["Seaside"]
	end
	if bit.band(sel,0x8)~=0 then
		card_list=kingdom_card_list["Alchemy"]
	end
	if bit.band(sel,0x10)~=0 then
		card_list=kingdom_card_list["Prosperity"]
	end
	--add cards to the game
	for i=1,10 do
		local random=Duel.GetRandomNumber(1,#card_list)
		local code=card_list[random]
		local card=Duel.CreateCard(PLAYER_ONE,code)
		Duel.SendtoDeck(card,PLAYER_ONE,SEQ_DECK_TOP,REASON_RULE)
		--add kingdom card status
		card:SetStatus(STATUS_KINGDOM,true)
		table.remove(card_list,random)
	end
	--move cards to the supply
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
	--add potion to the game
	if bit.band(sel,0x8)~=0 then
		local card=Duel.CreateCard(PLAYER_TWO,CARD_POTION)
		Duel.MoveToField(card,PLAYER_ONE,PLAYER_TWO,LOCATION_MZONE,POS_FACEUP_ATTACK,true,ZONE_POTION)
	end
	--add platinum and colony to the game
	if bit.band(sel,0x10)~=0 then
		if Duel.SelectYesNo(PLAYER_ONE,YESNOMSG_USEPLATINUM) and Duel.SelectYesNo(PLAYER_TWO,YESNOMSG_USEPLATINUM) then
			Rule.platinum=true
			Rule.colony=true
		end
	end
end
--set up base cards
function Rule.setup_base_cards()
	local card1=Duel.CreateCard(PLAYER_TWO,CARD_COPPER)
	local card2=Duel.CreateCard(PLAYER_TWO,CARD_SILVER)
	local card3=(Rule.platinum==false and Duel.CreateCard(PLAYER_TWO,CARD_GOLD) or Duel.CreateCard(PLAYER_TWO,CARD_PLATINUM))
	local card4=Duel.CreateCard(PLAYER_TWO,CARD_ESTATE)
	local card5=Duel.CreateCard(PLAYER_TWO,CARD_DUCHY)
	local card6=(Rule.colony==false and Duel.CreateCard(PLAYER_TWO,CARD_PROVINCE) or Duel.CreateCard(PLAYER_TWO,CARD_COLONY))
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
			elseif c:IsCode(CARD_PLATINUM) then c:AddCounter(COUNTER_COPIES,12)
			elseif c:IsCode(CARD_POTION) then c:AddCounter(COUNTER_COPIES,16)
			elseif c:IsStatus(STATUS_KINGDOM) or c:IsType(TYPE_CURSE) then c:AddCounter(COUNTER_COPIES,10) end
		end
		--raise event for setup
		Duel.RaiseEvent(c,EVENT_CUSTOM+EVENT_SETUP,Effect.GlobalEffect(),0,0,0,0)
	end
end
--start turn
function Rule.StartTurnOperation(e,tp,eg,ep,ev,re,r,rp)
	local turnp=Duel.GetTurnPlayer()
	Duel.AddAction(turnp,1)
	Duel.AddBuy(turnp,1)
	Duel.AddCoin(turnp,0)
	if Duel.CheckPotionRules() then
		Duel.AddPotion(turnp,0)
	end
end
--put in play
function Rule.PutInPlayOperation(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	local cp=rc:GetControler()
	if rc:IsType(TYPE_ACTION) and not rc:IsType(TYPE_REACTION) then
		if re:IsHasProperty(EFFECT_FLAG_PLAY_PARAM) then
			Duel.RemoveAction(cp,1)
		end
		Duel.SendtoInPlay(rc,REASON_RULE)
		--raise event for playing action cards
		Duel.RaiseSingleEvent(rc,EVENT_CUSTOM+EVENT_PLAY,e,0,0,0,0)
	elseif rc:IsType(TYPE_TREASURE) then
		local g=Duel.GetMatchingGroup(Card.IsType,cp,LOCATION_HAND,0,nil,TYPE_TREASURE)
		Duel.SendtoInPlay(g,REASON_RULE)
		local coin=g:GetSum(Card.GetCoin)
		local potion=g:GetSum(Card.GetPotion)
		--check for "Copper produces an extra $1 this turn" ("Coppersmith" 2-013)
		local ct=g:FilterCount(Card.IsCode,nil,CARD_COPPER)
		if ct>0 then
			local t={Duel.IsPlayerAffectedByEffect(cp,EFFECT_UPDATE_COPPER_PRODUCE)}
			for _,te in pairs(t) do
				if type(te:GetValue())=="function" then
					coin=coin+(ct*te:GetValue())(te,c)
				else
					coin=coin+(ct*te:GetValue())
				end
			end
		end
		if coin>0 then Duel.AddCoin(cp,coin) end
		if potion>0 then Duel.AddPotion(cp,potion) end
		--raise event for playing treasure cards
		for tc in aux.Next(g) do
			Duel.RaiseSingleEvent(tc,EVENT_CUSTOM+EVENT_PLAY,e,0,0,0,0)
		end
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
		--check for "You may play an Action card from your hand twice" ("Throne Room" 1-024)
		and not rc:IsHasEffect(EFFECT_PLAY_ACTION_TWICE)
		--check for "You may play an Action card from your hand three times" ("King's Court" 5-026)
		and not rc:IsHasEffect(EFFECT_PLAY_ACTION_THRICE)
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
function Rule.CleanupFilter(c)
	return c:IsType(TYPE_ACTION) and c:IsCanBeCleanedUp()
end
function Rule.CleanupOperation(e,tp,eg,ep,ev,re,r,rp)
	local turnp=Duel.GetTurnPlayer()
	local g1=Duel.GetMatchingGroup(aux.InPlayFilter(Rule.CleanupFilter),turnp,LOCATION_INPLAY,0,nil)
	local g2=Duel.GetMatchingGroup(Rule.CleanupFilter,turnp,LOCATION_HAND,0,nil)
	g1:Merge(g2)
	Duel.SendtoDPile(g1,REASON_RULE+REASON_DISCARD,turnp)
	local g3=Duel.GetMatchingGroup(aux.InPlayFilter(Card.IsCanBeCleanedUp),turnp,LOCATION_INPLAY,0,nil)
	local g4=Duel.GetMatchingGroup(Card.IsCanBeCleanedUp,turnp,LOCATION_HAND,0,nil)
	g3:Merge(g4)
	Duel.SendtoDPile(g3,REASON_RULE+REASON_DISCARD,turnp)
	Duel.Draw(turnp,Duel.GetDrawCount(turnp),REASON_RULE)
	Duel.EndTurn()
end
--show score
function Rule.ShowScoreOperation(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetVP(PLAYER_ONE)
	local ct2=Duel.GetVP(PLAYER_TWO)
	if Duel.GetScore(PLAYER_ONE)~=ct1 and ct1>=0 then Duel.SetScore(PLAYER_ONE,ct1) end
	if Duel.GetScore(PLAYER_TWO)~=ct2 and ct2>=0 then Duel.SetScore(PLAYER_TWO,ct2) end
end
--end game
function Rule.EndGameCondition(e)
	return not Duel.CheckProvincePile() or Duel.GetEmptySupplyPiles()>=3
end
function Rule.EndGameOperation(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(aux.TRUE,PLAYER_ONE,LOCATION_ALL-LOCATION_DECK-LOCATION_SUPPLY,0,nil)
	local g2=Duel.GetMatchingGroup(aux.TRUE,PLAYER_TWO,LOCATION_ALL-LOCATION_DECK-LOCATION_SUPPLY,0,nil)
	local sg1=Duel.GetMatchingGroup(aux.TrashFilter(),PLAYER_ONE,LOCATION_TRASH,0,nil)
	local sg2=Duel.GetMatchingGroup(aux.TrashFilter(),PLAYER_TWO,LOCATION_TRASH,0,nil)
	g1:Sub(sg1)
	g2:Sub(sg2)
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(g1,PLAYER_ONE,SEQ_DECK_SHUFFLE,REASON_RULE)
	Duel.SendtoDeck(g2,PLAYER_TWO,SEQ_DECK_SHUFFLE,REASON_RULE)
	local g3=Duel.GetMatchingGroup(Card.IsHasVP,PLAYER_ONE,LOCATION_DECK,0,nil)
	local g4=Duel.GetMatchingGroup(Card.IsHasVP,PLAYER_TWO,LOCATION_DECK,0,nil)
	Duel.SendtoHand(g3,PLAYER_ONE,REASON_RULE)
	Duel.ConfirmCards(PLAYER_TWO,g3)
	Duel.SendtoHand(g4,PLAYER_TWO,REASON_RULE)
	Duel.ConfirmCards(PLAYER_ONE,g4)
	local ct1=Duel.GetVP(PLAYER_ONE)
	local ct2=Duel.GetVP(PLAYER_TWO)
	if ct1>ct2 then
		Duel.Win(PLAYER_ONE,WIN_REASON_VP)
	elseif ct1<ct2 then
		Duel.Win(PLAYER_TWO,WIN_REASON_VP)
	elseif ct1==ct2 then
		Duel.Win(PLAYER_NONE,WIN_REASON_VP)
	end
end
--override yugioh rules
--set level status
function Rule.set_level_status()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetOperation(Rule.SetLevelStatusOp)
	Duel.RegisterEffect(e1,0)
end
function Rule.EnableLevelStatusFilter(c)
	return not c:IsStatus(STATUS_NO_COST) and c:GetCost()==0
end
function Rule.DisableLevelStatusFilter(c)
	return c:IsStatus(STATUS_NO_COST) and c:GetCost()>0
end
function Rule.SetLevelStatusOp(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(Rule.EnableLevelStatusFilter,0,LOCATION_ALL,LOCATION_ALL,nil)
	for c1 in aux.Next(g1) do
		c1:SetStatus(STATUS_NO_COST,true)
	end
	local g2=Duel.GetMatchingGroup(Rule.DisableLevelStatusFilter,0,LOCATION_ALL,LOCATION_ALL,nil)
	for c2 in aux.Next(g2) do
		c2:SetStatus(STATUS_NO_COST,false)
	end
end
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
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_LOSE_LP)
	Duel.RegisterEffect(e2,0)
end
