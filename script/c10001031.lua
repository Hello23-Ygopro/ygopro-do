--Witch
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, gain supply
	aux.AddActionEffect(c,scard.op1)
end
--draw, gain supply
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	local tc=Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsType),tp,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,TYPE_CURSE)
	Duel.GainCards(tc,REASON_EFFECT,1-tp)
end
