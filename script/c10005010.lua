--Worker's Village
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, add buy
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action, add buy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,2)
	Duel.AddBuy(tp,1)
end
