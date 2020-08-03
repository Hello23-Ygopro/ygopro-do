--Pearl Diver
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, confirm
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action, confirm
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
	local g=Duel.GetDeckbottomGroup(tp,1)
	Duel.ConfirmCards(tp,g)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>1 and Duel.SelectYesNo(tp,YESNOMSG_TODECKTOP) then
		Duel.MoveSequence(g:GetFirst(),SEQ_DECK_TOP)
	end
end
