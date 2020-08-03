--Salvager
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add buy, trash, add coin
	aux.AddActionEffect(c,scard.op1)
end
--add buy, trash, add coin
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddBuy(tp,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToTrash,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()==0 or Duel.Trash(g,REASON_EFFECT,tp)==0 then return end
	local tc=Duel.GetOperatedCard()
	Duel.AddCoin(tp,tc:GetCost())
end
--[[
	FAQ

	Official FAQ
	* For example if you trash an Estate, which costs $2, you get +$2 (and +1 Buy).
	* If you trash a card with P (Potion) or D (Debt) in the cost (from other expansions), you get nothing for those
	symbols.
	http://wiki.dominionstrategy.com/index.php/Salvager#FAQ
]]
