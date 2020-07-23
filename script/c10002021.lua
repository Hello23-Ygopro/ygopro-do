--Trading Post
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--trash, gain
	aux.AddActionEffect(c,scard.op1)
end
--trash, gain
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToTrash,tp,LOCATION_HAND,0,2,2,nil)
	if g:GetCount()>0 and Duel.Trash(g,REASON_EFFECT,tp)>=2 then
		local tc=Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsCode),tp,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,CARD_SILVER)
		Duel.GainCards(tc,REASON_EFFECT,tp,LOCATION_HAND)
	end
end
--[[
	FAQ

	Official FAQ
	* If you have only one card in hand, trash it and nothing else happens; if you have 2 or more cards in hand, trash
	exactly 2 of them and gain a Silver, putting it into your hand.

	http://wiki.dominionstrategy.com/index.php/Trading_Post#FAQ
]]
