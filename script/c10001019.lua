--Moneylender
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--trash, add coin
	aux.AddActionEffect(c,scard.op1)
end
--trash, add coin
function scard.trfilter(c)
	return c:IsCode(CARD_COPPER) and c:IsAbleToTrash()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local g=Duel.SelectMatchingCard(tp,scard.trfilter,tp,LOCATION_HAND,0,0,1,nil)
	if g:GetCount()>0 and Duel.Trash(g,REASON_EFFECT,tp)>0 then
		Duel.AddCoin(tp,3)
	end
end
--[[
	FAQ

	Official FAQ
	* You only get the +$3 if you actually trashed a Copper.

	http://wiki.dominionstrategy.com/index.php/Moneylender#FAQ
]]
