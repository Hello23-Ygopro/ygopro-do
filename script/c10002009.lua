--Wishing Well
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, confirm (to hand)
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action, confirm (to hand)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ANNOUNCENAME)
	local code=Duel.AnnounceCard(tp)
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsCode(code) then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(tc,tp,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	end
end
--[[
	FAQ

	Official FAQ
	* Reveal the top card of your deck. If it has the name you named, put it into your hand, otherwise leave it on your
	deck.

	http://wiki.dominionstrategy.com/index.php/Wishing_Well#FAQ

	References
		1. Archfiend's Oath
		https://github.com/Fluorohydride/ygopro-scripts/blob/ed35639/c22796548.lua#L35
]]
