--Loan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCoin(c,1)
	--treasure
	aux.EnableTreasureAttribute(c)
	--confirm (discard deck, trash)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_PLAY)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--confirm (discard deck, trash)
function scard.filter(c)
	return c:IsType(TYPE_TREASURE) and (c:IsAbleToDPile() or c:IsAbleToTrash())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	local g1=Duel.GetMatchingGroup(scard.filter,tp,LOCATION_DECK,0,nil)
	local deck_count=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if g1:GetCount()==0 then
		Duel.ConfirmDecktop(tp,deck_count)
	end
	local g2=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_DPILE,0,nil)
	if g1:GetCount()==0 and g2:GetCount()>0 then
		Duel.SendtoDeck(g2,tp,SEQ_DECK_SHUFFLE,REASON_RULE)
		Duel.ShuffleDeck(tp)
	end
	g1=Duel.GetMatchingGroup(scard.filter,tp,LOCATION_DECK,0,nil)
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
		local option_list={}
		local sel_list={}
		if card:IsAbleToDPile() then
			table.insert(option_list,OPTION_DISCARDDECK)
			table.insert(sel_list,1)
		end
		if card:IsAbleToTrash() then
			table.insert(option_list,OPTION_TRASHDECK)
			table.insert(sel_list,2)
		end
		local opt=sel_list[Duel.SelectOption(tp,table.unpack(option_list))+1]
		if opt==1 then
			Duel.DisableShuffleCheck()
			Duel.SendtoDPile(card,REASON_EFFECT+REASON_DISCARD,tp)
		else
			Duel.DisableShuffleCheck()
			Duel.Trash(card,REASON_EFFECT,tp)
		end
		Duel.DiscardDeck(tp,deck_count-seq-1,REASON_EFFECT)
	end
end
--[[
	FAQ

	Official FAQ
	* This is similar to Throne Room, but plays the Action three times rather than twice.
	* For example if you start a turn by playing King's Court on Village, you would draw a card, get +2 Actions, draw
	another card, get +2 Actions again, draw a 3rd card, and get +2 Actions again, leaving you with 6 Actions.
	* If you King's Court a King's Court, you may play an Action card three times, then may play another Action card three
	times, then may play a 3rd Action card three times; you do not play one Action card nine times.
	http://wiki.dominionstrategy.com/index.php/Loan#FAQ

	References
	* Magical Merchant
	https://github.com/Fluorohydride/ygopro-scripts/blob/cb54f7a/c32362575.lua#L10
]]
