--Ambassador
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm, to supply, gain
	aux.AddActionEffect(c,scard.op1)
end
--confirm, to supply, gain
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g1=Duel.SelectMatchingCard(tp,aux.NOT(Card.IsPublic),tp,LOCATION_HAND,0,1,1,nil)
	if g1:GetCount()==0 then return end
	Duel.ConfirmCards(1-tp,g1)
	Duel.ShuffleHand(tp)
	local tc1=g1:GetFirst()
	local code=tc1:GetCode()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOSUPPLY)
	local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_HAND,0,0,2,nil,code)
	if g2:GetCount()>0 then
		Duel.SendtoSupply(g2)
	end
	local tc2=Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsCode),1-tp,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,code)
	Duel.BreakEffect()
	Duel.GainCards(tc2,REASON_EFFECT,1-tp)
end
--[[
	FAQ

	Official FAQ
	* First you reveal a card from your hand.
	* Then take 0, 1, or 2 copies of that card from your hand and put them on top of their Supply pile.
	* At the end of the game, all cards from the mat are returned to your deck for scoring.

	Other Rules clarifications
	* If you reveal a card which is not from the Supply, such as Spoils, Madman, Mercenary, or Shelters, Ambassador does
	nothing. Similarly, because none of the cards bought through Black Market are in the Supply, if you reveal a card
	bought through Black Market, Ambassador does nothing.
	* If you reveal a card which is part of a Supply pile with differently named cards, such as Ruins or Knights, you can
	only return two cards to the supply pile if they have the same name. Other players will only gain cards with that name,
	and only if they are on the top of the deck (no digging).
	* If you empty either the Province pile or a third Supply pile, then use Ambassador so that the pile is no longer empty
	at the end of your turn, the game does not end.
	* If you return the bottom card of a Split pile when there is a top card on top, you still put the returned bottom card
	on top, not under the remaining top cards.
	http://wiki.dominionstrategy.com/index.php/Ambassador#FAQ
]]
