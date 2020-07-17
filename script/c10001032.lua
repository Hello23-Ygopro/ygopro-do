--Adventurer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm (to hand, discard deck)
	aux.AddActionEffect(c,scard.op1)
end
--confirm (to hand, discard deck)
function scard.thfilter(c)
	return c:IsType(TYPE_TREASURE) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.thfilter,tp,LOCATION_DECK,0,nil)
	local deck_count=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if g:GetCount()==0 then
		Duel.ConfirmDecktop(tp,deck_count)
		Duel.Hint(HINT_MESSAGE,tp,ERROR_NOTARGETS)
		Duel.DiscardDeck(tp,deck_count,REASON_EFFECT)
		return
	end
	local seq1=-1
	local seq2=0
	local thgroup=Group.CreateGroup()
	for tc in aux.Next(g) do
		if thgroup:GetCount()<2 and tc:GetSequence()>seq1 then
			seq1=tc:GetSequence()
			thgroup:AddCard(tc)
		end
		if thgroup:GetCount()==2 then
			seq2=tc:GetSequence()
		end
	end
	if thgroup:GetCount()==2 then
		Duel.ConfirmDecktop(tp,deck_count-seq2+thgroup:GetCount()-1)
	else
		Duel.ConfirmDecktop(tp,deck_count-seq1)
	end
	if thgroup:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(thgroup,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,thgroup)
		Duel.ShuffleHand(tp)
		if thgroup:GetCount()==2 then
			Duel.DiscardDeck(tp,deck_count-seq2-thgroup:GetCount(),REASON_EFFECT)
		else
			Duel.DiscardDeck(tp,deck_count-seq1-1,REASON_EFFECT)
		end
	else
		Duel.DiscardDeck(tp,deck_count-seq1,REASON_EFFECT)
	end
end
--[[
	FAQ

	Official FAQ
	* If you have to shuffle in the middle, shuffle. Don't shuffle in the revealed cards as these cards do not go to the
	Discard pile until you have finished revealing cards.
	* If you run out of cards after shuffling and still only have one Treasure, you get just that one Treasure.

	http://wiki.dominionstrategy.com/index.php/Adventurer#FAQ
	
	References
		1. Magical Merchant
		https://github.com/Fluorohydride/ygopro-scripts/blob/cb54f7a/c32362575.lua#L10
]]
