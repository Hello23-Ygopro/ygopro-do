--Secret Chamber
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard, add coin
	aux.AddActionEffect(c,scard.op1)
	--reaction (draw, to deck)
	aux.AddReactionEffect(c,scard.op2,aux.ReactionCondition)
end
--discard, add coin
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.DiscardHand(tp,aux.TRUE,0,MAX_NUMBER,REASON_EFFECT+REASON_DISCARD)
	if ct>0 then
		Duel.AddCoin(tp,ct)
	end
end
--reaction (draw, to deck)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.ConfirmCards(1-tp,e:GetHandler())
	Duel.Draw(tp,2,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,2,2,nil)
	if g:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SendtoDeck(g,tp,SEQ_DECK_TOP,REASON_EFFECT)
	end
end
--[[
	FAQ

	Official FAQ
	* You may choose to discard zero cards, but then you will get zero additional $.
	* Revealing Secret Chamber happens prior to resolving what an Attack does to you. For example, if another player plays
	Thief, you can reveal Secret Chamber, draw 2 cards, put 2 back, and then you resolve getting hit by the Thief.
	* You can reveal more than one Reaction card in response to an Attack. For example, after revealing the Secret Chamber
	in response to an Attack and resolving the effect of the Secret Chamber, you can still reveal a Moat to avoid the
	Attack completely.

	Other Rules clarifications
	* Revealing the Secret Chamber alone does NOT prevent the attack from affecting you. You can reveal Secret Chamber
	even in response to an attack that does not affect the top of your deck, like Witch.
	* You must reveal the Secret Chamber as soon as the Attack is played, but before any text on it is resolved. So if
	your opponent plays Minion or Pirate Ship, you must finish drawing cards and then putting cards back on top before
	your opponent makes their choice for which action on attack card to take.
	http://wiki.dominionstrategy.com/index.php/Secret_Chamber#FAQ
]]
