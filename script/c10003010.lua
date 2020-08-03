--Warehouse
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, discard hand
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action, discard hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,3,REASON_EFFECT)
	Duel.AddAction(tp,1)
	Duel.DiscardHand(tp,aux.TRUE,3,3,REASON_EFFECT+REASON_DISCARD)
end
