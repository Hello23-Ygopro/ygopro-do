--Vault
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, discard hand, add coin
	aux.AddActionEffect(c,scard.op1)
end
--draw, discard hand, add coin
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	Duel.ShuffleHand(tp)
	local ct=Duel.DiscardHand(tp,aux.TRUE,0,MAX_NUMBER,REASON_EFFECT+REASON_DISCARD)
	if ct>0 then
		Duel.AddCoin(tp,ct)
	end
	if Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)==0 or not Duel.SelectYesNo(1-tp,YESNOMSG_DISCARDHAND) then return end
	if Duel.DiscardHand(1-tp,aux.TRUE,2,2,REASON_EFFECT+REASON_DISCARD)>=2 then
		Duel.Draw(1-tp,1,REASON_EFFECT)
	end
end
--[[
	FAQ

	Official FAQ
	* "Any number" includes zero.
	* A player with just one card can choose to discard it, but won't draw a card.
	* A player who discards but then has no cards left to draw shuffles in the discards before drawing.
	http://wiki.dominionstrategy.com/index.php/Vault#FAQ
]]
