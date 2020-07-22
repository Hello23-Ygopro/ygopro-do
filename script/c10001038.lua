--Sentry
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, confirm (trash/discard deck, sort deck)
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action, confirm (trash/discard deck, sort deck)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
	local g=Duel.GetDecktopGroup(tp,2)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local sg1=g:FilterSelect(tp,Card.IsAbleToTrash,0,2,nil)
	Duel.DisableShuffleCheck()
	if sg1:GetCount()>0 then
		Duel.Trash(sg1,REASON_EFFECT,tp)
		g:Sub(sg1)
	end
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local sg2=g:FilterSelect(tp,Card.IsAbleToDPile,0,g:GetCount(),nil)
	if sg2:GetCount()>0 then
		Duel.SendtoDPile(sg2,REASON_EFFECT+REASON_DISCARD,tp)
		g:Sub(sg2)
	end
	Duel.SortDecktop(tp,tp,g:GetCount())
end
--[[
	References
		1. Dark Magical Circle
		https://github.com/Fluorohydride/ygopro-scripts/blob/cb54f7a/c47222536.lua#L38
		
]]
