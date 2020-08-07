--Apothecary
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddPotionCost(c,1)
	--draw, add action, confirm (to hand)
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action, confirm (to hand)
function scard.thfilter(c)
	return c:IsCode(CARD_COPPER,CARD_POTION) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
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
