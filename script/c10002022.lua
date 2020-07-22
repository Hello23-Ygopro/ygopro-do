--Tribute
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm, discard deck (add action, add coin, draw)
	aux.AddActionEffect(c,scard.op1)
end
--confirm, discard deck (add action, add coin, draw)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.ConfirmDecktop(1-tp,2)
	Duel.DiscardDeck(1-tp,2,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	if g:GetClassCount(Card.GetCode)>=2 then
		if g:IsExists(Card.IsType,1,nil,TYPE_ACTION) then
			Duel.AddAction(tp,2)
		end
		if g:IsExists(Card.IsType,1,nil,TYPE_TREASURE) then
			Duel.AddCoin(tp,2)
		end
		if g:IsExists(Card.IsType,1,nil,TYPE_VICTORY) then
			Duel.Draw(tp,2,REASON_EFFECT)
		end
	else
		Duel.Hint(HINT_MESSAGE,tp,ERROR_NOBONUSES)
	end
end
--[[
	FAQ

	Official FAQ
	* You get bonuses for the types of cards revealed, counting only the different cards.
	* A card with 2 types gives you both bonuses.
	* So if the player to your left reveals Copper and Harem, you get +$4 and +2 cards; if he reveals 2 Silvers, you just
	get +$2.

	Other Rules clarifications.
	* Revealing an Estate Inherited as a Crown would give you all three bonuses.

	http://wiki.dominionstrategy.com/index.php/Tribute#FAQ
]]
