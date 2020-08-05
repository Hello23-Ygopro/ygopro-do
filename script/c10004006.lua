--Scrying Pool
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddPotionCost(c,1)
	--add action, confirm (discard deck, to hand)
	aux.AddActionEffect(c,scard.op1)
end
--add action, confirm (discard deck, to hand)
function scard.thfilter(c)
	return not c:IsType(TYPE_ACTION) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddAction(tp,1)
	Duel.ConfirmDecktop(tp,1)
	if Duel.IsPlayerCanDiscardDeck(tp,1) and Duel.SelectYesNo(tp,YESNOMSG_DISCARDDECK) then
		Duel.DiscardDeck(tp,1,REASON_EFFECT)
	end
	Duel.ConfirmDecktop(1-tp,1)
	if Duel.IsPlayerCanDiscardDeck(1-tp,1) and Duel.SelectYesNo(tp,YESNOMSG_DISCARDDECK) then
		Duel.DiscardDeck(1-tp,1,REASON_EFFECT)
	end
	Duel.BreakEffect()
	local g1=Duel.GetMatchingGroup(scard.thfilter,tp,LOCATION_DECK,0,nil)
	local deck_count=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if g1:GetCount()==0 then
		Duel.ConfirmDecktop(tp,deck_count)
	end
	local g2=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_DPILE,0,nil)
	if g1:GetCount()==0 and g2:GetCount()>0 then
		Duel.SendtoDeck(g2,tp,SEQ_DECK_SHUFFLE,REASON_RULE)
		Duel.ShuffleDeck(tp)
	end
	g1=Duel.GetMatchingGroup(scard.thfilter,tp,LOCATION_DECK,0,nil)
	deck_count=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if g1:GetCount()==0 then
		Duel.ConfirmDecktop(tp,deck_count)
		Duel.Hint(HINT_MESSAGE,tp,ERROR_NOTARGETS)
	else
		local seq=-1
		for tc in aux.Next(g1) do
			if tc:GetSequence()>seq then
				seq=tc:GetSequence()
			end
		end
		Duel.ConfirmDecktop(tp,deck_count-seq)
		local g3=Duel.GetDecktopGroup(tp,deck_count-seq)
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(g3,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g3)
		Duel.ShuffleHand(tp)
	end
end
--[[
	FAQ

	Official FAQ
	* If you run out of cards without revealing a [non-]Action card, shuffle your discard pile and keep going. If you have
	no discard pile left either, stop there.

	Other Rules clarifications
	* Cards with multiple types, one of which is Action, are Actions.
	* The only cards that go into your hand are the ones revealed as part of revealing cards until finding a non-Action;
	you do not get discarded cards from the first part of what Scrying Pool did, or cards from other players' decks.
	http://wiki.dominionstrategy.com/index.php/Scrying_Pool#FAQ
]]
