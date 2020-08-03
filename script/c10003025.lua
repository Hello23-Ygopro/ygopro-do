--Treasury
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, add coin
	aux.AddActionEffect(c,scard.op1)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TO_DPILE)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op2)
	c:RegisterEffect(e1)
end
--draw, add action, add coin
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
	Duel.AddCoin(tp,1)
end
--to deck
function scard.cfilter(c,tid)
	return c:IsType(TYPE_VICTORY) and c:IsReason(REASON_BUY) and c:GetTurnID()==tid
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_INPLAY) and c:IsAbleToDeck()
		and not Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_ALL,LOCATION_ALL,1,nil,Duel.GetTurnCount())
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.SelectEffectYesNo(tp,c,YESNOMSG_USEEFFECT) then
		Duel.Hint(HINT_CARD,0,sid)
		Duel.SendtoDeck(c,tp,SEQ_DECK_TOP,REASON_EFFECT)
	end
end
--[[
	FAQ

	Official FAQ
	* If you did not buy any Victory cards during your turn, you may put any or all of your played Treasuries on top of
	your deck during Clean-up.
	* If you did buy at least one Victory card, all of the Treasuries are discarded normally.
	* Gaining a Victory card without buying it, such as with Smugglers, does not prevent you from putting Treasuries on
	your deck.
	http://wiki.dominionstrategy.com/index.php/Treasury#FAQ

	References
	* Over Limit
	https://github.com/Fluorohydride/ygopro-scripts/blob/d10310a/c23282832.lua#L15
]]
