--Ironworks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--gain (add action, add coin, draw)
	aux.AddActionEffect(c,scard.op1)
end
--gain (add action, add coin, draw)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_GAIN)
	local g=Duel.SelectMatchingCard(tp,aux.SupplyFilter(Card.IsCostBelow),0,LOCATION_SUPPLY,LOCATION_SUPPLY,1,1,nil,4)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	if Duel.GainCards(g,REASON_EFFECT,tp)==0 then return end
	local tc=Duel.GetOperatedCard()
	if tc:IsType(TYPE_ACTION) then
		Duel.AddAction(tp,1)
	end
	if tc:IsType(TYPE_TREASURE) then
		Duel.AddCoin(tp,1)
	end
	if tc:IsType(TYPE_VICTORY) then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
--[[
	FAQ

	Official FAQ
	* A card with 2 types gives you both bonuses; if you use Ironworks to gain a MillMill, you both draw a card and get +1
	Action.

	Other Rules clarifications
	* If you do not actually gain the card you chose, such as because of Trader or Possession, you get no bonus.
	* If you gain an Inherited Estate, you get +1 Action and +1 Card.
	http://wiki.dominionstrategy.com/index.php/Ironworks#FAQ
]]
