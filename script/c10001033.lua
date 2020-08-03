--Harbinger
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, to deck
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action, to deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_DPILE,0,0,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,tp,SEQ_DECK_TOP,REASON_EFFECT)
	end
end
--[[
	FAQ

	Official FAQ
	* Putting a card on top is optional.
	http://wiki.dominionstrategy.com/index.php/Harbinger#FAQ
]]
