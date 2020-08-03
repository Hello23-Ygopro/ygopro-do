--Ghost Ship
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, to deck
	aux.AddActionEffect(c,scard.op1)
end
--draw, to deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	local ct=g:FilterCount(Card.IsAbleToDeck,nil)
	if ct>=4 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TODECK)
		local sg=g:FilterSelect(1-tp,Card.IsAbleToDeck,ct-3,ct-3,nil)
		Duel.SendtoDeck(sg,1-tp,SEQ_DECK_TOP,REASON_EFFECT)
	end
end
