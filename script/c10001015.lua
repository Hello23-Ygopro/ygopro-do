--Bureaucrat
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--gain (to deck), to deck
	aux.AddActionEffect(c,scard.op1)
end
--gain (to deck), to deck
function scard.tdfilter(c)
	return c:IsType(TYPE_VICTORY) and c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_GAIN)
	local g1=Duel.SelectMatchingCard(tp,aux.SupplyFilter(Card.IsCode),tp,LOCATION_SUPPLY,LOCATION_SUPPLY,1,1,nil,CARD_SILVER)
	if g1:GetCount()>0 then
		Duel.HintSelection(g1)
		Duel.GainCards(g1,REASON_EFFECT,tp,LOCATION_DECK)
	end
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g2:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TODECK)
	local sg=g2:FilterSelect(1-tp,scard.tdfilter,1,1,nil)
	if sg:GetCount()>0 then
		Duel.ConfirmCards(tp,sg)
		Duel.SendtoDeck(sg,1-tp,SEQ_DECK_SHUFFLE,REASON_EFFECT)
		Duel.ShuffleDeck(1-tp)
	else
		Duel.ConfirmCards(tp,g2)
	end
	Duel.ShuffleHand(1-tp)
end
