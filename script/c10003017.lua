--Sea Hag
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard deck, gain (to deck)
	aux.AddActionEffect(c,scard.op1)
end
--discard deck, gain (to deck)
function scard.tdfilter(c)
	return c:IsType(TYPE_CURSE) and c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(1-tp,1,REASON_EFFECT)
	local tc=Duel.GetFirstMatchingCard(aux.SupplyFilter(scard.tdfilter),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil)
	Duel.BreakEffect()
	Duel.GainCards(tc,REASON_EFFECT,1-tp,LOCATION_DECK)
end
