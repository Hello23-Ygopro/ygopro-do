--Lookout
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add action, confirm (trash, discard deck)
	aux.AddActionEffect(c,scard.op1)
end
--add action, confirm (trash, discard deck)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddAction(tp,1)
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local sg1=g:FilterSelect(tp,Card.IsAbleToTrash,1,1,nil)
	Duel.DisableShuffleCheck()
	if sg1:GetCount()>0 then
		Duel.Trash(sg1,REASON_EFFECT,tp)
		g:Sub(sg1)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg2=g:FilterSelect(tp,Card.IsAbleToDPile,1,1,nil)
	if sg2:GetCount()>0 then
		Duel.SendtoDPile(sg2,REASON_EFFECT+REASON_DISCARD,tp)
	end
end
