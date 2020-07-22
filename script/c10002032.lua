--Replace
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--trash, gain (to deck)
	aux.AddActionEffect(c,scard.op1)
end
--trash, gain (to deck)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToTrash,tp,LOCATION_HAND,0,1,1,nil)
	if g1:GetCount()==0 or Duel.Trash(g1,REASON_EFFECT,tp)==0 then return end
	local tc1=Duel.GetOperatedCard()
	local cost=tc1:GetCost()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_GAIN)
	local g2=Duel.SelectMatchingCard(tp,aux.SupplyFilter(Card.IsCostBelow),tp,LOCATION_SUPPLY,LOCATION_SUPPLY,1,1,nil,cost+2)
	if g2:GetCount()==0 then return end
	local tc2=g2:GetFirst()
	Duel.HintSelection(g2)
	if tc2:IsType(TYPE_ACTION+TYPE_TREASURE) then
		Duel.GainCards(g2,REASON_EFFECT,tp,LOCATION_DECK)
	else
		Duel.GainCards(g2,REASON_EFFECT,tp)
	end
	if tc2:IsType(TYPE_VICTORY) then
		local tc3=Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsType),tp,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,TYPE_CURSE)
		Duel.GainCards(tc3,REASON_EFFECT,1-tp)
	end
end
--[[
	FAQ

	Official FAQ
	* It is possible to get both bonuses; if you gain Harem, Mill, or Nobles with Replace, it both goes on your deck and
	causes the other players to each gain a Curse.

	http://wiki.dominionstrategy.com/index.php/Replace#FAQ
]]
