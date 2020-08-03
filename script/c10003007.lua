--Fishing Village
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add action, add coin
	aux.AddActionEffect(c,scard.op1)
end
--add action, add coin
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddAction(tp,2)
	Duel.AddCoin(tp,1)
	local c=e:GetHandler()
	--duration (add action, add coin)
	local e1=aux.AddDurationEffect(c,c,aux.DurationCondition,scard.op2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_ACTION,3)
	aux.SetDurationState(c)
end
--duration (add action, add coin)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.AddAction(tp,1)
	Duel.AddCoin(tp,1)
	--end duration
	aux.RemoveDurationState(e:GetHandler())
end
