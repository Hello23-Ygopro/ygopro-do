--Goons
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add buy, add coin, discard hand
	aux.AddActionEffect(c,scard.op1)
	--add vp
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_BUY)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCondition(aux.AND(aux.SelfInPlayCondition,aux.EventPlayerCondition(PLAYER_SELF)))
	e1:SetOperation(scard.op2)
	c:RegisterEffect(e1)
end
--add buy, add coin, discard hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddBuy(tp,1)
	Duel.AddCoin(tp,2)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	if ct>=4 then
		Duel.DiscardHand(1-tp,aux.TRUE,ct-3,ct-3,REASON_EFFECT+REASON_DISCARD)
	end
end
--add vp
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	for i=1,eg:GetCount() do
		Duel.Hint(HINT_CARD,0,sid)
		Duel.AddPlayerToken(tp,COUNTER_VP_TOKEN,1)
	end
end
--[[
	FAQ

	Official FAQ
	* You get +1VP for each card you buy, but do not get a +1VP for gaining a card some other way.
	* Multiple copies of Goons are cumulative; if you have two Goons in play and buy a Silver, you get +2VP.
	* However if you King's Court a Goons, despite having played the card 3 times, there is still only one copy of it in
	play, so buying Silver would only get you +1VP.

	Other Rules clarifications
	* Buying Events does not give you VP.
	http://wiki.dominionstrategy.com/index.php/Goons#FAQ
]]
