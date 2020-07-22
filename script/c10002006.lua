--Shanty Town
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add action, confirm, draw
	aux.AddActionEffect(c,scard.op1)
end
--add action, confirm, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddAction(tp,2)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
	if not g:IsExists(Card.IsType,1,nil,TYPE_ACTION) then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
--[[
	FAQ

	Official FAQ
	* If you pick "trash 2 cards from your hand" and only have one card in hand, you trash that card; if you choose that
	option and have 2 or more cards in hand, you have to trash 2.

	http://wiki.dominionstrategy.com/index.php/Shanty_Town#FAQ
]]
