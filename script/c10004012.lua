--Apprentice
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add action, trash, draw
	aux.AddActionEffect(c,scard.op1)
end
--add action, trash, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddAction(tp,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToTrash,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()==0 or Duel.Trash(g,REASON_EFFECT,tp)==0 then return end
	local tc=Duel.GetOperatedCard()
	Duel.Draw(tp,tc:GetCost(),REASON_EFFECT)
	if tc:IsHasPotionCost() then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
--[[
	FAQ

	Official FAQ
	* If you trash a card costing $0, such as Curse or Copper, you do not draw any cards.
	* Otherwise you draw a card per $1 the card you trashed cost, and another two cards if it had P [Potion] in its cost.
	For example if you trashed a Golem, which costs $4P, you would draw 6 cards.

	Other Rules clarifications
	* If you trash a card with D [debt] in the cost, the D component is ignored.
	http://wiki.dominionstrategy.com/index.php/Apprentice#FAQ
]]
