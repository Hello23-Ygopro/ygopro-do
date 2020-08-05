--Golem
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddPotionCost(c,1)
	--confirm (discard deck, play action)
	aux.AddActionEffect(c,scard.op1)
end
--confirm (discard deck, play action)
function scard.playfilter(c)
	return c:IsType(TYPE_ACTION) and not c:IsCode(sid)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.playfilter,tp,LOCATION_DECK,0,nil)
	local deck_count=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if g:GetCount()==0 then
		Duel.ConfirmDecktop(tp,deck_count)
		Duel.Hint(HINT_MESSAGE,tp,ERROR_NOTARGETS)
		Duel.DiscardDeck(tp,deck_count,REASON_EFFECT)
		return
	end
	local seq1=-1
	local seq2=0
	local playgroup=Group.CreateGroup()
	for tc in aux.Next(g) do
		if playgroup:GetCount()<2 and tc:GetSequence()>seq1 then
			seq1=tc:GetSequence()
			playgroup:AddCard(tc)
		end
		if playgroup:GetCount()==2 then
			seq2=tc:GetSequence()
		end
	end
	if playgroup:GetCount()==2 then
		Duel.ConfirmDecktop(tp,deck_count-seq2+playgroup:GetCount()-1)
	else
		Duel.ConfirmDecktop(tp,deck_count-seq1)
	end
	if playgroup:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.PlayAction(playgroup)
		if playgroup:GetCount()==2 then
			Duel.DiscardDeck(tp,deck_count-seq2-playgroup:GetCount(),REASON_EFFECT)
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
	* Discard all of the revealed cards except for the non-Golem Actions you found. If you did not find any, you are done.
	* If you found one, play it. If you found two, play them both, in either order. You cannot choose not to play one of
	them.
	* These Action cards are not in your hand and so are unaffected by things that look for cards in your hand. For example
	if one of them is Throne Room, you cannot use it on the other one.
	http://wiki.dominionstrategy.com/index.php/Golem#FAQ
]]
