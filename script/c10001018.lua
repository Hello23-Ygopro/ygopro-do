--Militia
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add coin, discard hand
	aux.AddActionEffect(c,scard.op1)
end
--add coin, discard hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddCoin(tp,2)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	if ct>3 then
		Duel.DiscardHand(1-tp,aux.TRUE,ct-3,ct-3,REASON_EFFECT+REASON_DISCARD)
	end
end
