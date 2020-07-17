--Cellar
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add action, discard hand, draw
	aux.AddActionEffect(c,scard.op1)
end
--add action, discard hand, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddAction(tp,1)
	local ct=Duel.DiscardHand(tp,aux.TRUE,0,MAX_NUMBER,REASON_EFFECT+REASON_DISCARD)
	if ct>0 then
		Duel.BreakEffect()
		Duel.Draw(tp,ct,REASON_EFFECT)
	end
end
