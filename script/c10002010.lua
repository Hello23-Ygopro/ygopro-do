--Baron
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add buy, discard hand, add coin or gain
	aux.AddActionEffect(c,scard.op1)
end
--add buy, discard hand, add coin or gain
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddBuy(tp,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_HAND,0,0,1,nil,CARD_ESTATE)
	if g:GetCount()>0 and Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD,tp)>0 then
		Duel.AddCoin(tp,4)
	else
		local tc=Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsCode),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,CARD_ESTATE)
		Duel.GainCards(tc,REASON_EFFECT,tp)
	end
end
