--Transmute
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddPotionCost(c,1)
	--trash (gain)
	aux.AddActionEffect(c,scard.op1)
end
--trash (gain)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToTrash,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()==0 or Duel.Trash(g,REASON_EFFECT,tp)==0 then return end
	local tc=Duel.GetOperatedCard()
	if tc:IsType(TYPE_ACTION) then
		scard.gain(tp,CARD_DUCHY)
	end
	if tc:IsType(TYPE_TREASURE) then
		scard.gain(tp,sid)
	end
	if tc:IsType(TYPE_VICTORY) then
		scard.gain(tp,CARD_GOLD)
	end
end
function scard.gain(tp,code)
	local tc=Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsCode),tp,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,code)
	Duel.GainCards(tc,REASON_EFFECT,tp)
end
--[[
	FAQ

	Official FAQ
	* If you trash a Curse to this, you do not get anything.
	* If you trash a card with more than one type to this, you get each applicable thing. For example if you trash an
	Action-Victory card (such as Nobles, from Dominion: Intrigue), you gain both a Duchy and a Gold.

	Other Rules clarifications
	* If you Transmute an Inherited Estate, you will gain a Gold (for trashing a Victory card) and a Duchy (for trashing
	an Action card).
	http://wiki.dominionstrategy.com/index.php/Transmute#FAQ
]]
