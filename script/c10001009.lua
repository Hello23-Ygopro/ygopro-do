--Chapel
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--trash
	aux.AddActionEffect(c,scard.op1)
end
--trash
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToTrash,tp,LOCATION_HAND,0,1,4,nil)
	if g:GetCount()>0 then
		Duel.Trash(g,REASON_EFFECT,tp)
	end
end
