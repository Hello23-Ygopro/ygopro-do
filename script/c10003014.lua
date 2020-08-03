--Navigator
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add coin, confirm (discard deck or sort deck)
	aux.AddActionEffect(c,scard.op1)
end
--add coin, confirm (discard deck or sort deck)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddCoin(tp,2)
	Duel.ConfirmDecktop(tp,5)
	if Duel.IsPlayerCanDiscardDeck(tp,5) and Duel.SelectYesNo(tp,YESNOMSG_DISCARDDECK) then
		Duel.DiscardDeck(tp,5,REASON_EFFECT)
	else
		Duel.SortDecktop(tp,tp,5)
	end
end
