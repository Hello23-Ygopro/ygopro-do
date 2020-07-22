--Upgrade
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, trash, gain
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action, trash, gain
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToTrash,tp,LOCATION_HAND,0,1,1,nil)
	if g1:GetCount()==0 or Duel.Trash(g1,REASON_EFFECT,tp)==0 then return end
	local tc=Duel.GetOperatedCard()
	local cost=tc:GetCost()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_GAIN)
	local g2=Duel.SelectMatchingCard(tp,aux.SupplyFilter(Card.IsCost),tp,LOCATION_SUPPLY,LOCATION_SUPPLY,1,1,nil,cost+1)
	if g2:GetCount()>0 then
		Duel.HintSelection(g2)
		Duel.GainCards(g2,REASON_EFFECT,tp)
	end
end
