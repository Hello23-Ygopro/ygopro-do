--Patrol
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, confirm (to hand)
	aux.AddActionEffect(c,scard.op1)
end
--draw, confirm (to hand)
function scard.thfilter(c)
	return c:IsType(TYPE_VICTORY+TYPE_CURSE) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,3,REASON_EFFECT)
	Duel.ConfirmDecktop(tp,4)
	local g=Duel.GetDecktopGroup(tp,4)
	local sg=g:Filter(scard.thfilter,nil)
	if sg:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(sg,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
		g:Sub(sg)
	end
	Duel.SortDecktop(tp,tp,g:GetCount())
end
