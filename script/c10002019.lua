--Saboteur
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm (trash, gain, discard deck)
	aux.AddActionEffect(c,scard.op1)
end
--confirm (trash, gain, discard deck)
function scard.trfilter(c)
	return c:IsCostAbove(3) and c:IsAbleToTrash()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(scard.trfilter,tp,0,LOCATION_DECK,nil)
	local deck_count=Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)
	if g1:GetCount()==0 then
		Duel.ConfirmDecktop(1-tp,deck_count)
		Duel.Hint(HINT_MESSAGE,1-tp,ERROR_NOTARGETS)
		Duel.DiscardDeck(1-tp,deck_count,REASON_EFFECT)
		return
	end
	local seq=-1
	local trcard=nil
	for tc in aux.Next(g1) do
		if tc:GetSequence()>seq then 
			seq=tc:GetSequence()
			trcard=tc
		end
	end
	Duel.ConfirmDecktop(1-tp,deck_count-seq)
	Duel.DisableShuffleCheck()
	if Duel.Trash(trcard,REASON_EFFECT,1-tp)>0 then
		local tc=Duel.GetOperatedCard()
		local cost=tc:GetCost()
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_GAIN)
		local g2=Duel.SelectMatchingCard(1-tp,aux.SupplyFilter(Card.IsCostBelow),1-tp,LOCATION_SUPPLY,LOCATION_SUPPLY,0,1,nil,cost-2)
		if g2:GetCount()>0 then
			Duel.HintSelection(g2)
			Duel.GainCards(g2,REASON_EFFECT,1-tp)
		end
		Duel.DiscardDeck(1-tp,deck_count-seq-1,REASON_EFFECT)
	else
		Duel.DiscardDeck(1-tp,deck_count-seq,REASON_EFFECT)
	end
end
--[[
	FAQ

	Official FAQ
	* If he goes through all of his cards without finding a card costing $3 or more, he just discards everything revealed
	and is done.

	http://wiki.dominionstrategy.com/index.php/Saboteur#FAQ
	
	References
		1. Magical Merchant
		https://github.com/Fluorohydride/ygopro-scripts/blob/cb54f7a/c32362575.lua#L10
]]
