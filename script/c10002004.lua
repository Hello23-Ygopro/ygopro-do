--Great Hall
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddVP(c,1)
	--draw, add action
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
end
