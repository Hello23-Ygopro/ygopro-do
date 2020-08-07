--Forge
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--trash, gain
	aux.AddActionEffect(c,scard.op1)
end
--trash, gain
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local cost=0
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToTrash,tp,LOCATION_HAND,0,0,MAX_NUMBER,nil)
	if g1:GetCount()>0 then
		Duel.Trash(g1,REASON_EFFECT,tp)
		cost=cost+g1:GetSum(Card.GetCost)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_GAIN)
	local g2=Duel.SelectMatchingCard(tp,aux.SupplyFilter(Card.IsCost),0,LOCATION_SUPPLY,LOCATION_SUPPLY,1,1,nil,cost)
	if g2:GetCount()>0 then
		Duel.HintSelection(g2)
		Duel.GainCards(g2,REASON_EFFECT,tp)
	end
end
--[[
	FAQ

	Official FAQ
	* "Any number" includes zero.
	* If you trash no cards, you have to gain a card costing $0 if you can.
	* If there is no card at the required cost, you do not gain a card.
	* P (on cards from Dominion: Alchemy) and D (on cards from Dominion: Empires) are not added, and the card you gain
	cannot have those symbols in its cost.
	http://wiki.dominionstrategy.com/index.php/Forge#FAQ
]]
