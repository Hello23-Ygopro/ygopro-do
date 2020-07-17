--Thief
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm (trash, gain supply, discard deck)
	aux.AddActionEffect(c,scard.op1)
end
--confirm (trash, gain supply, discard deck)
function scard.trfilter(c)
	return c:IsType(TYPE_TREASURE) and c:IsAbleToTrash()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.ConfirmDecktop(1-tp,2)
	local g1=Duel.GetDecktopGroup(1-tp,2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local sg=g1:FilterSelect(tp,scard.trfilter,1,1,nil)
	Duel.DisableShuffleCheck()
	g1:Sub(sg)
	if sg:GetCount()>0 and Duel.Trash(sg,REASON_EFFECT,1-tp)>0 then
		local g2=Duel.GetOperatedGroup()
		if g2:IsExists(Card.IsLocation,1,nil,LOCATION_TRASH) and Duel.SelectYesNo(tp,YESNOMSG_GAINCARD) then
			Duel.GainCards(g2,REASON_EFFECT,tp)
		end
	end
	if g1:GetCount()>0 then
		Duel.SendtoDPile(g1,REASON_EFFECT+REASON_DISCARD,1-tp)
	end
end
--[[
	References
		1. Chronomaly Technology
		https://github.com/Fluorohydride/ygopro-scripts/blob/c04a9daa50/c90951921.lua#L54
]]
