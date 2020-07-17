--Chancellor
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add coin, to discard pile
	aux.AddActionEffect(c,scard.op1)
end
--add coin, to discard pile
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddCoin(tp,2)
	local g=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,YESNOMSG_DECKTODPILE) then
		Duel.SendtoDPile(g,REASON_EFFECT,tp)
	end
end
