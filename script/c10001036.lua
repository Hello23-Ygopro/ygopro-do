--Poacher
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, add coin, discard hand
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action, add coin, discard hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
	Duel.AddCoin(tp,1)
	local ct=Duel.GetEmptySupplyPiles()
	Duel.DiscardHand(tp,aux.TRUE,ct,ct,REASON_EFFECT+REASON_DISCARD)
end
