--Workshop
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--gain supply
	aux.AddActionEffect(c,scard.op1)
end
--gain supply
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_GAIN)
	local g=Duel.SelectMatchingCard(tp,aux.SupplyFilter(Card.IsCostBelow),tp,LOCATION_SUPPLY,LOCATION_SUPPLY,1,1,nil,4)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.GainCards(g,REASON_EFFECT,tp)
	end
end
