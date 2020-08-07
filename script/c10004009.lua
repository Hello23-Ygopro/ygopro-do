--Familiar
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddPotionCost(c,1)
	--draw, add action, gain
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action, gain
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
	local tc=Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsType),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,TYPE_CURSE)
	Duel.GainCards(tc,REASON_EFFECT,1-tp)
end
