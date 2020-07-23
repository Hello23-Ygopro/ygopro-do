--Mill
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddVP(c,1)
	--draw, add action, discard hand, add coin
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action, discard hand, add coin
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0 or not Duel.SelectYesNo(tp,YESNOMSG_DISCARDHAND) then return end
	if Duel.DiscardHand(tp,aux.TRUE,2,2,REASON_EFFECT+REASON_DISCARD)>=2 then
		Duel.AddCoin(tp,2)
	end
end
--[[
	FAQ

	Official FAQ
	* You can choose to discard 2 cards even if you only have one card in hand, but you only get +$2 if you actually
	discarded 2 cards.

	http://wiki.dominionstrategy.com/index.php/Mill#FAQ
]]
