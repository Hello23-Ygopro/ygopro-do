--Smithy
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.AddActionEffect(c,scard.op1)
end
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,3,REASON_EFFECT)
end
