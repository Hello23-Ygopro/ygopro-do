--Remodel
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--trash, gain
	aux.AddActionEffect(c,scard.op1)
end
--trash, gain
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToTrash,tp,LOCATION_HAND,0,1,1,nil)
	if g1:GetCount()==0 or Duel.Trash(g1,REASON_EFFECT,tp)==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	local cost=tc:GetCost()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_GAIN)
	local g2=Duel.SelectMatchingCard(tp,aux.SupplyFilter(Card.IsCostBelow),tp,LOCATION_SUPPLY,LOCATION_SUPPLY,1,1,nil,cost+2)
	if g2:GetCount()>0 then
		Duel.HintSelection(g2)
		Duel.GainCards(g2,REASON_EFFECT,tp)
	end
end
--[[
	FAQ

	Official FAQ
	* The gained card does not need to cost exactly $2 more than the trashed card; it can cost that much or less, and can
	even be another copy of the trashed card.

	Other Rules clarifications
	* You must trash a card from your hand if you have one.

	http://wiki.dominionstrategy.com/index.php/Remodel#FAQ
]]
