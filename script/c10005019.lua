--Venture
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCoin(c,1)
	--treasure
	aux.EnableTreasureAttribute(c)
	--confirm (discard deck, play treasure)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_PLAY)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--confirm (discard deck, play treasure)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	local g1=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_DECK,0,nil,TYPE_TREASURE)
	local deck_count=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if g1:GetCount()==0 then
		Duel.ConfirmDecktop(tp,deck_count)
	end
	local g2=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_DPILE,0,nil)
	if g1:GetCount()==0 and g2:GetCount()>0 then
		Duel.SendtoDeck(g2,tp,SEQ_DECK_SHUFFLE,REASON_RULE)
		Duel.ShuffleDeck(tp)
	end
	g1=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_DECK,0,nil,TYPE_TREASURE)
	deck_count=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if g1:GetCount()==0 then
		Duel.ConfirmDecktop(tp,deck_count)
		Duel.Hint(HINT_MESSAGE,tp,ERROR_NOTARGETS)
		Duel.DiscardDeck(tp,deck_count,REASON_EFFECT)
	else
		local seq=-1
		local card=nil
		for tc in aux.Next(g1) do
			if tc:GetSequence()>seq then
				seq=tc:GetSequence()	
				card=tc
			end
		end
		Duel.ConfirmDecktop(tp,deck_count-seq)
		Duel.DisableShuffleCheck()
		Duel.PlayTreasure(card)
		Duel.DiscardDeck(tp,deck_count-seq-1,REASON_EFFECT)
	end
end
