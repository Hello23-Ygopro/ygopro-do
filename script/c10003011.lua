--Caravan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
	local c=e:GetHandler()
	--duration (draw)
	local e1=aux.AddDurationEffect(c,c,aux.DurationCondition,scard.op2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_ACTION,3)
	aux.SetDurationState(c)
end
--duration (draw)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Draw(tp,1,REASON_EFFECT)
	--end duration
	e:GetHandler():ResetEffect(EFFECT_DONOT_CLEANUP,RESET_CODE)
end
