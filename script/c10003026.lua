--Wharf
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add buy
	aux.AddActionEffect(c,scard.op1)
end
--draw, add buy
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	Duel.AddBuy(tp,1)
	local c=e:GetHandler()
	--duration (draw, add buy)
	local e1=aux.AddDurationEffect(c,c,aux.DurationCondition,scard.op2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_ACTION,3)
	aux.SetDurationState(c,true)
end
--duration (draw, add buy)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Draw(tp,2,REASON_EFFECT)
	Duel.AddBuy(tp,1)
	--end duration
	aux.SetDurationState(e:GetHandler(),false)
end
