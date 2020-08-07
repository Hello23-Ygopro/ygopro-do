--Peddler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, add coin
	aux.AddActionEffect(c,scard.op1)
	--cost less
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_COST)
	e1:SetCondition(aux.PhaseCondition(PHASE_BUY))
	e1:SetValue(scard.val1)
	c:RegisterEffect(e1)
end
--draw, add action, add coin
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
	Duel.AddCoin(tp,1)
end
--cost less
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(aux.InPlayFilter(Card.IsType),c:GetControler(),LOCATION_INPLAY,0,nil,TYPE_ACTION)*-2
end
--[[
	FAQ

	Official FAQ
	* This cost applies to all Peddler cards, including ones in hands and decks.
	* It never costs less than $0.
	* If you play King's Court on Worker's Village, for example, that is just two Action cards you have in play, even
	though you played the Worker's Village three times.
	* Buying cards using the promotional card Black Market is something that does not happen during a Buy phase, so Peddler
	still costs $8 then.

	Other Rules clarifications
	* The card Scepter can cause actions to be played during the buy phase, so if you replay a card such as Workshop, it
	will see the reduced price of Peddler.
	http://wiki.dominionstrategy.com/index.php/Peddler#FAQ
]]
