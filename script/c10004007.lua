--University
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddPotionCost(c,1)
	--add action, gain
	aux.AddActionEffect(c,scard.op1)
end
--add action, gain
function scard.gainfilter(c)
	return c:IsType(TYPE_ACTION) and c:IsCostBelow(5)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddAction(tp,2)
	local tc=Duel.GetFirstMatchingCard(aux.SupplyFilter(scard.gainfilter),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil)
	if tc and Duel.SelectYesNo(tp,YESNOMSG_GAINCARD) then
		Duel.GainCards(tc,REASON_EFFECT,tp)
	end
end
