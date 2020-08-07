--Mine
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--trash, gain (to hand)
	aux.AddActionEffect(c,scard.op1)
end
--trash, gain (to hand)
function scard.trfilter(c)
	return c:IsType(TYPE_TREASURE) and c:IsAbleToTrash()
end
function scard.thfilter(c,cost)
	return c:IsType(TYPE_TREASURE) and c:IsCostBelow(cost+3) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local g1=Duel.SelectMatchingCard(tp,scard.trfilter,tp,LOCATION_HAND,0,0,1,nil)
	if g1:GetCount()==0 or Duel.Trash(g1,REASON_EFFECT,tp)==0 then return end
	local tc=Duel.GetOperatedCard()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_GAIN)
	local g2=Duel.SelectMatchingCard(tp,aux.SupplyFilter(scard.thfilter),0,LOCATION_SUPPLY,LOCATION_SUPPLY,1,1,nil,tc:GetCost())
	if g2:GetCount()>0 then
		Duel.HintSelection(g2)
		Duel.GainCards(g2,REASON_EFFECT,tp,LOCATION_HAND)
	end
end
