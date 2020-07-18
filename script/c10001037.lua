--Bandit
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--gain, confirm (trash, discard deck)
	aux.AddActionEffect(c,scard.op1)
end
--gain, confirm (trash, discard deck)
function scard.trfilter(c)
	return c:IsType(TYPE_TREASURE) and not c:IsCode(CARD_COPPER) and c:IsAbleToTrash()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_GAIN)
	local g1=Duel.SelectMatchingCard(tp,aux.SupplyFilter(Card.IsCode),tp,LOCATION_SUPPLY,LOCATION_SUPPLY,1,1,nil,CARD_GOLD)
	if g1:GetCount()>0 then
		Duel.HintSelection(g1)
		Duel.GainCards(g1,REASON_EFFECT,tp)
	end
	Duel.ConfirmDecktop(1-tp,2)
	local g2=Duel.GetDecktopGroup(1-tp,2)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TRASH)
	local sg=g2:FilterSelect(1-tp,scard.trfilter,1,1,nil)
	Duel.DisableShuffleCheck()
	if sg:GetCount()>0 then
		Duel.Trash(sg,REASON_EFFECT,1-tp)
		g2:Sub(sg)
	end
	if g2:GetCount()>0 then
		Duel.SendtoDPile(g2,REASON_EFFECT+REASON_DISCARD,1-tp)
	end
end
--[[
	References
		1. Kuribandit
		https://github.com/Fluorohydride/ygopro-scripts/blob/6324c1c/c16404809.lua#L41
]]
