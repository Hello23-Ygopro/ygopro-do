--City
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, add buy, add coin
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action, add buy, add coin
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,2)
	if Duel.GetEmptySupplyPiles()>=1 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
	if Duel.GetEmptySupplyPiles()>=2 then
		Duel.AddBuy(tp,1)
		Duel.AddCoin(tp,1)
	end
end
--[[
	FAQ

	Official FAQ
	* This only checks how many piles are empty when you play it; what you got does not change if a pile becomes empty (or
	non-empty, such as due to Ambassador from Dominion: Seaside).
	* This only counts Supply piles, not non-Supply piles like Spoils from Dark Ages.
	http://wiki.dominionstrategy.com/index.php/City#FAQ
]]
