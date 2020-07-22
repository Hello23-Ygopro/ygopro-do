--Courtyard
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, to deck
	aux.AddActionEffect(c,scard.op1)
end
--draw, to deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,3,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,tp,SEQ_DECK_SHUFFLE,REASON_EFFECT)
		Duel.ShuffleDeck(tp)
	end
end
