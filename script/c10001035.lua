--Vassal
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add coin, discard deck, play action
	aux.AddActionEffect(c,scard.op1)
end
--add coin, discard deck, play action
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddCoin(tp,2)
	if Duel.DiscardDeck(tp,1,REASON_EFFECT)==0 then return end
	local tc=Duel.GetOperatedCard()
	if tc:IsType(TYPE_ACTION) and Duel.SelectYesNo(tp,YESNOMSG_PLAY) then
		Duel.PlayAction(tc)
	end
end
--[[
	FAQ

	Official FAQ
	* If you do play it, you move it into your play area and follow its instructions; this does not use up one of your
	Action plays for the turn.
	http://wiki.dominionstrategy.com/index.php/Vassal#FAQ
]]
