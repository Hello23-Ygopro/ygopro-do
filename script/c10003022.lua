--Merchant Ship
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add coin
	aux.AddActionEffect(c,scard.op1)
end
--add coin
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddCoin(tp,2)
	local c=e:GetHandler()
	--duration (add coin)
	local e1=aux.AddDurationEffect(c,c,aux.DurationCondition,scard.op2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_ACTION,3)
	aux.SetDurationState(c,true)
end
--duration (add coin)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.AddCoin(tp,2)
	--end duration
	aux.SetDurationState(e:GetHandler(),false)
end
