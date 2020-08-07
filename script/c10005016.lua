--Rabble
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, confirm (discard deck)
	aux.AddActionEffect(c,scard.op1)
end
--draw, confirm (discard deck)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,3,REASON_EFFECT)
	Duel.ConfirmDecktop(1-tp,3)
	local g=Duel.GetDecktopGroup(1-tp,3)
	local sg=g:Filter(Card.IsType,nil,TYPE_ACTION+TYPE_TREASURE)
	if sg:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoDPile(sg,REASON_EFFECT+REASON_DISCARD,1-tp)
		g:Sub(sg)
	end
	Duel.SortDecktop(1-tp,1-tp,g:GetCount())
end
