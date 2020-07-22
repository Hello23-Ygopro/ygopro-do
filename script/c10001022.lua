--Spy
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, confirm (discard deck)
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action, confirm (discard deck)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
	Duel.ConfirmDecktop(tp,1)
	if Duel.IsPlayerCanDiscardDeck(tp,1) and Duel.SelectYesNo(tp,YESNOMSG_DISCARDDECK) then
		Duel.DiscardDeck(tp,1,REASON_EFFECT)
	end
	Duel.ConfirmDecktop(1-tp,1)
	if Duel.IsPlayerCanDiscardDeck(1-tp,1) and Duel.SelectYesNo(tp,YESNOMSG_DISCARDDECK) then
		Duel.DiscardDeck(1-tp,1,REASON_EFFECT)
	end
end
