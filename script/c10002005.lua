--Masquerade
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, pass, trash
	aux.AddActionEffect(c,scard.op1)
end
--draw, pass, trash
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	Duel.ShuffleHand(tp)
	scard.pass(tp)
	scard.pass(1-tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToTrash,tp,LOCATION_HAND,0,0,1,nil)
	if g:GetCount()>0 then
		Duel.BreakEffect()
		Duel.Trash(g,REASON_EFFECT,tp)
	end
end
function scard.pass(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PASS)
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,1-tp,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
	end
end
--[[
	FAQ

	Other Rules clarifications
	* Masquerade's mechanism for changing card ownership is unique in the game, since it uses the word "pass" to indicate
	a change of card ownership. The consequence of this wording is that the player receiving a passed card is not
	"gaining" it. So, for example, they cannot react to the card passing with Watchtower.

	http://wiki.dominionstrategy.com/index.php/Masquerade#FAQ
]]
