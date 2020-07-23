--Scout
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add action, confirm (to hand)
	aux.AddActionEffect(c,scard.op1)
end
--add action, confirm (to hand)
function scard.thfilter(c)
	return c:IsType(TYPE_VICTORY) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddAction(tp,1)
	Duel.ConfirmDecktop(tp,4)
	local g=Duel.GetDecktopGroup(tp,4)
	local sg=g:Filter(scard.thfilter,nil)
	Duel.DisableShuffleCheck()
	Duel.SendtoHand(sg,tp,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,sg)
	Duel.ShuffleHand(tp)
	Duel.SortDecktop(tp,tp,g:GetCount())
end
--[[
	References
		1. Spellbook Library of the Heliosphere
		https://github.com/Fluorohydride/ygopro-scripts/blob/6324c1c/c20822520.lua#L64
]]