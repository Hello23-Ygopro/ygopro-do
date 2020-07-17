--Library
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, discard hand
	aux.AddActionEffect(c,scard.op1)
end
--draw, discard hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	Duel.Draw(tp,7-ct,REASON_EFFECT)
	Duel.DiscardHand(tp,Card.IsType,0,ct,REASON_EFFECT+REASON_DISCARD,nil,TYPE_ACTION)
end
--[[
	FAQ

	Official FAQ
	* You look at cards one at a time, putting each one into your hand or setting it aside, until you have 7 cards in
	hand; then you discard the set aside cards.
	* If you shuffle in the middle of doing this, you do not shuffle in the set aside cards.
	* Only Action cards can be set aside.
	* You are not forced to set aside Action cards; that is just an option.
	* If you already have 7 cards in hand to start, you do not draw any cards.

	Other Rules clarifications
	* If you have more than 7 cards in hand, you don't draw anything.
	* If you have less than 7 cards in hand and your -1 Card token is on your deck, take it off before drawing, even if
	you have no cards in your deck and/or discard pile.

	http://wiki.dominionstrategy.com/index.php/Library#FAQ
]]
