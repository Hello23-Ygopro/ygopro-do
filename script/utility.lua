Auxiliary={}
aux=Auxiliary

--
function Auxiliary.Stringid(code,id)
	return code*16+id
end
--
function Auxiliary.Next(g)
	local first=true
	return	function()
				if first then first=false return g:GetFirst()
				else return g:GetNext() end
			end
end
--
function Auxiliary.NULL()
end
--
function Auxiliary.TRUE()
	return true
end
--
function Auxiliary.FALSE()
	return false
end
--
function Auxiliary.AND(...)
	local function_list={...}
	return	function(...)
				local res=false
				for i,f in ipairs(function_list) do
					res=f(...)
					if not res then return res end
				end
				return res
			end
end
--
function Auxiliary.OR(...)
	local function_list={...}
	return	function(...)
				local res=false
				for i,f in ipairs(function_list) do
					res=f(...)
					if res then return res end
				end
				return res
			end
end
--
function Auxiliary.NOT(f)
	return	function(...)
				return not f(...)
			end
end
--
function Auxiliary.BeginPuzzle(effect)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TURN_END)
	e1:SetCountLimit(1)
	e1:SetOperation(Auxiliary.PuzzleOp)
	Duel.RegisterEffect(e1,0)
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_SKIP_DP)
	e2:SetTargetRange(1,0)
	Duel.RegisterEffect(e2,0)
	local e3=Effect.GlobalEffect()
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_SKIP_SP)
	e3:SetTargetRange(1,0)
	Duel.RegisterEffect(e3,0)
end
function Auxiliary.PuzzleOp(e,tp)
	Duel.SetLP(0,0)
end
--
function Auxiliary.TargetEqualFunction(f,value,...)
	local ext_params={...}
	return	function(effect,target)
				return f(target,table.unpack(ext_params))==value
			end
end
--
function Auxiliary.TargetBoolFunction(f,...)
	local ext_params={...}
	return	function(effect,target)
				return f(target,table.unpack(ext_params))
			end
end
--
function Auxiliary.FilterEqualFunction(f,value,...)
	local ext_params={...}
	return	function(target)
				return f(target,table.unpack(ext_params))==value
			end
end
--
function Auxiliary.FilterBoolFunction(f,...)
	local ext_params={...}
	return	function(target)
				return f(target,table.unpack(ext_params))
			end
end
--get a card script's name and id
function Auxiliary.GetID()
	local str=string.match(debug.getinfo(2,'S')['source'],"c%d+%.lua")
	str=string.sub(str,1,string.len(str)-4)
	local scard=_G[str]
	local sid=tonumber(string.sub(str,2))
	return scard,sid
end

--register the coin a card is worth
function Auxiliary.AddCoin(c,val)
	local mt=getmetatable(c)
	mt.coin=val
end
--register the victory points a card is worth
function Auxiliary.AddVP(c,val)
	local mt=getmetatable(c)
	mt.vp=val
end
--register the potion a card is worth
function Auxiliary.AddPotion(c,val)
	local mt=getmetatable(c)
	mt.potion=val
end
--register a card's potion cost
function Auxiliary.AddPotionCost(c,val)
	local mt=getmetatable(c)
	mt.potion_cost=val
end

--list of all card types in the game
--Note: Update this list if a new card type is introduced
Auxiliary.type_list={TYPE_ACTION,TYPE_TREASURE,TYPE_VICTORY,TYPE_CURSE,TYPE_ATTACK,TYPE_REACTION,TYPE_DURATION}

--treasure card
function Auxiliary.EnableTreasureAttribute(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAY_PARAM)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(TIMING_BUY_PHASE,0)
	e1:SetCondition(Auxiliary.TreasureCondition)
	e1:SetTarget(Auxiliary.TreasureTarget)
	e1:SetOperation(Auxiliary.TreasureOperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_CUSTOM+EVENT_PLAY_TREASURE)
	e2:SetOperation(Auxiliary.TreasureOperation)
	c:RegisterEffect(e2)
	return e1,e2
end
function Auxiliary.TreasureCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0
end
function Auxiliary.TreasureFilter(c,coin,potion)
	return c:GetCost()<=coin and (potion>0 or c:GetPotionCost()<=potion) and c:IsCanBeBought()
end
function Auxiliary.TreasureTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	local f=Auxiliary.SupplyFilter(Auxiliary.TreasureFilter)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_HAND,0,nil,TYPE_TREASURE)
	local coin=g:GetSum(Card.GetCoin)
	local potion=g:GetSum(Card.GetPotion)
	if chk==0 then return Duel.IsExistingMatchingCard(f,0,LOCATION_SUPPLY,LOCATION_SUPPLY,1,nil,coin,potion) end
end
function Auxiliary.TreasureOperation(e,tp,eg,ep,ev,re,r,rp)
	local f=Auxiliary.SupplyFilter(Auxiliary.TreasureFilter)
	local coin=Duel.GetCoins(tp)
	local potion=Duel.GetPotions(tp)
	local g=Duel.GetMatchingGroup(f,0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,coin,potion)
	while Duel.GetBuys(tp)>0 and g:GetCount()>0 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_GAIN)
		local tc=g:Select(tp,0,1,nil):GetFirst()
		if not tc then break end
		Duel.HintSelection(Group.FromCards(tc))
		Duel.GainCards(tc,REASON_BUY,tp)
		Duel.RemoveBuy(tp,1)
		Duel.RemoveCoin(tp,tc:GetCost())
		Duel.RemovePotion(tp,tc:GetPotionCost())
		coin=Duel.GetCoins(tp)
		potion=Duel.GetPotions(tp)
		g=g:Filter(f,nil,coin,potion)
		--raise event for buying cards
		Duel.RaiseEvent(tc,EVENT_CUSTOM+EVENT_BUY,e,0,tp,tp,0)
		Duel.RaiseSingleEvent(tc,EVENT_CUSTOM+EVENT_BUY,e,0,tp,tp,0)
	end
end

--Action effects
--e.g. "Cellar" (1-008)
function Auxiliary.AddActionEffect(c,op_func)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAY_PARAM)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(TIMING_ACTION_PHASE,0)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_CUSTOM+EVENT_PLAY_ACTION)
	e2:SetOperation(op_func)
	c:RegisterEffect(e2)
	return e1,e2
end
--Reaction effects
--"When another player plays an Attack card, you may reveal this from your hand" (e.g. "Moat" 1-010)
function Auxiliary.AddReactionEffect(c,op_func,con_func)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(con_func)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	return e1
end
--Duration effects
--e.g. "Haven" (3-002)
function Auxiliary.AddDurationEffect(c,tc,con_func,op_func)
	--Note: Using EVENT_PHASE+PHASE_ACTION instead of EVENT_TURN_START causes YGOPro to crash
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TURN_START)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCountLimit(1)
	e1:SetLabel(Duel.GetTurnCount())
	e1:SetCondition(aux.AND(Auxiliary.SelfInPlayCondition,con_func))
	e1:SetOperation(op_func)
	tc:RegisterEffect(e1)
	return e1
end
--Set Duration state - do not clean up
function Auxiliary.SetDurationState(c,enable)
	--enable: true to enable, false to disable
	if enable==true then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DONOT_CLEANUP)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		return e1
	elseif enable==false then
		c:ResetEffect(EFFECT_DONOT_CLEANUP,RESET_CODE)
	end
end

--"Worth n VP"
--e.g. "Duke" (2-017)
function Auxiliary.AddChangeVP(c,val)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_VP)
	e1:SetValue(val)
	c:RegisterEffect(e1)
	return e1
end
--"Worth n $"
--e.g. "Philosopher's Stone" (4-010)
function Auxiliary.AddChangeCoin(c,val)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_COIN)
	e1:SetValue(val)
	c:RegisterEffect(e1)
	return e1
end

--condition to check who the event player is
function Auxiliary.EventPlayerCondition(p)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				return ep==player
			end
end
--condition to check if it is the given phase of the turn
function Auxiliary.PhaseCondition(phase)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				return Duel.GetCurrentPhase()==phase
			end
end
--condition for Reaction effects
--e.g. "Moat" (1-010)
function Auxiliary.ReactionCondition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsActiveType(TYPE_ATTACK)
end
--condition for Duration effects
--e.g. "Haven" (3-002)
function Auxiliary.DurationCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetTurnCount()~=e:GetLabel()
end
--condition to check if a card is in play
--e.g. "Philosopher's Stone" (4-010)
function Auxiliary.SelfInPlayCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_INPLAY) and not c:IsReason(REASON_TRASH)
end
--filter for a card in the supply
function Auxiliary.SupplyFilter(f)
	return	function(target,...)
				return (target:IsLocation(LOCATION_MZONE) or target:IsLocation(LOCATION_SZONE))
					and not target:IsCode(CARD_COUNTER_HOLDER)
					and (not f or f(target,...))
			end
end
--filter for a card in play
function Auxiliary.InPlayFilter(f)
	return	function(target,...)
				return target:IsLocation(LOCATION_INPLAY) and not target:IsReason(REASON_TRASH)
					and (not f or f(target,...))
			end
end
--filter for a card in the trash
function Auxiliary.TrashFilter(f)
	return	function(target,...)
				return target:IsLocation(LOCATION_TRASH) and target:IsReason(REASON_TRASH)
					and (not f or f(target,...))
			end
end
--utility entry for SelectUnselect loops
--returns bool if chk==0, returns Group if chk==1
function Auxiliary.SelectUnselectLoop(c,sg,mg,e,tp,minc,maxc,rescon)
	local res
	if sg:GetCount()>=maxc then return false end
	sg:AddCard(c)
	if sg:GetCount()<minc then
		res=mg:IsExists(Auxiliary.SelectUnselectLoop,1,sg,sg,mg,e,tp,minc,maxc,rescon)
	elseif sg:GetCount()<maxc then
		res=(not rescon or rescon(sg,e,tp,mg)) or mg:IsExists(Auxiliary.SelectUnselectLoop,1,sg,sg,mg,e,tp,minc,maxc,rescon)
	else
		res=(not rescon or rescon(sg,e,tp,mg))
	end
	sg:RemoveCard(c)
	return res
end
function Auxiliary.SelectUnselectGroup(g,e,tp,minc,maxc,rescon,chk,seltp,hintmsg,cancelcon,breakcon)
	local minc=minc and minc or 1
	local maxc=maxc and maxc or 99
	if chk==0 then return g:IsExists(Auxiliary.SelectUnselectLoop,1,nil,Group.CreateGroup(),g,e,tp,minc,maxc,rescon) end
	local hintmsg=hintmsg and hintmsg or 0
	local sg=Group.CreateGroup()
	while true do
		local cancel=sg:GetCount()>=minc and (not cancelcon or cancelcon(sg,e,tp,g))
		local mg=g:Filter(Auxiliary.SelectUnselectLoop,sg,sg,g,e,tp,minc,maxc,rescon)
		if (breakcon and breakcon(sg,e,tp,mg)) or mg:GetCount()<=0 or sg:GetCount()>=maxc then break end
		Duel.Hint(HINT_SELECTMSG,seltp,hintmsg)
		local tc=mg:SelectUnselect(sg,seltp,cancel,cancel)
		if not tc then break end
		if sg:IsContains(tc) then
			sg:RemoveCard(tc)
		else
			sg:AddCard(tc)
		end
	end
	return sg
end
--
function loadutility(file)
	local f=loadfile("expansions/script/"..file)
	if f==nil then
		dofile("script/"..file)
	else
		f()
	end
end
loadutility("bit.lua")
loadutility("card.lua")
loadutility("duel.lua")
loadutility("group.lua")
loadutility("lua.lua")
loadutility("rule.lua")
--[[
	References

	Terminology
	"Gain a card":
	* Sometimes a card will let you gain a card from a place other than the Supply, but by default gained cards come from
	the Supply.
	* Sometimes a card will let you gain a card to a location other than your discard pile, but by default all gained
	cards are put into your discard pile.
	"In play":
	* Only played cards are in play; set aside cards, cards in the trash, in the Supply, in hands, etc., are not in play.
	"Play a card":
	* When a card tells you to play a card, that does not use up an Action play for the turn.
	* As always, played cards go into play, not directly into the discard pile.
	"Set aside a card":
	* Set aside cards are not "in play".
	Shuffling
	* If you have to do anything with your deck - for example draw, look at, reveal, set aside, discard, or trash cards -
	and you need more cards than are left in your deck, first shuffle your discard pile and put it under your deck, then
	do the thing. If there are still not enough cards, you do the thing with however many cards you can.

	Additional Rules
	* When two things happen to different players at the same time, go in turn order starting with the player whose turn
	it is. For example, when a player plays Witch, the other players gain Curses in turn order, which may matter if the
	Curses run out.
	* When two things happen to one player at the same time, that player picks the order to do them, even if some are
	mandatory and some are not.
	* When a card gives you a choice ("choose one..."), you can pick any option, without considering whether or not you
	will be able to do it.
]]
