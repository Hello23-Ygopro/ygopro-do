--Diplomat
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action
	aux.AddActionEffect(c,scard.op1)
	--reaction (draw, discard hand)
	aux.AddReactionEffect(c,scard.op2,scard.con1)
end
--draw, add action
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)<=5 then
		Duel.AddAction(tp,2)
	end
end
--reaction (draw, discard hand)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return aux.ReactionCondition(e,tp,eg,ep,ev,re,r,rp) and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>=5
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.ConfirmCards(1-tp,e:GetHandler())
	Duel.Draw(tp,2,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.DiscardHand(tp,aux.TRUE,3,3,REASON_EFFECT+REASON_DISCARD)
end
