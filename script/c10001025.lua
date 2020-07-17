--Council Room
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add buy
	aux.AddActionEffect(c,scard.op1)
end
--draw, add buy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,4,REASON_EFFECT)
	Duel.AddBuy(tp,1)
	Duel.Draw(1-tp,1,REASON_EFFECT)
end
