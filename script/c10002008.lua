--Swindler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add coin, trash, gain
	aux.AddActionEffect(c,scard.op1)
end
--add coin, trash, gain
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddCoin(tp,2)
	if Duel.TrashDeck(1-tp,1,REASON_EFFECT)==0 then return end
	local tc=Duel.GetOperatedCard()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_GAIN)
	local g=Duel.SelectMatchingCard(tp,aux.SupplyFilter(Card.IsCost),tp,LOCATION_SUPPLY,LOCATION_SUPPLY,1,1,nil,tc:GetCost())
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.GainCards(g,REASON_EFFECT,1-tp)
	end
end
