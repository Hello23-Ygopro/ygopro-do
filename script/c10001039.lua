--Artisan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--gain (to hand), to deck
	aux.AddActionEffect(c,scard.op1)
end
--gain (to hand), to deck
function scard.thfilter(c)
	return c:IsCostBelow(5) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_GAIN)
	local g1=Duel.SelectMatchingCard(tp,aux.SupplyFilter(scard.thfilter),0,LOCATION_SUPPLY,LOCATION_SUPPLY,1,1,nil)
	if g1:GetCount()>0 then
		Duel.HintSelection(g1)
		Duel.GainCards(g1,REASON_EFFECT,tp,LOCATION_HAND)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g2=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
	if g2:GetCount()>0 then
		Duel.SendtoDeck(g2,tp,SEQ_DECK_TOP,REASON_EFFECT)
	end
end
