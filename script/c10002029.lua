--Secret Passage
--Not fully implemented: Duel.MoveSequence deck sequences are limited to 0, 1 and 2
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, to deck
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action, to deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	Duel.AddAction(tp,1)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ANNOUNCESEQ)
	local opt=Duel.SelectOption(tp,OPTION_DECKTOP,OPTION_DECKBOT,OPTION_DECKSHF)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=g:Select(tp,1,1,nil)
	Duel.SendtoDeck(sg,tp,opt,REASON_EFFECT)
	if opt==OPTION_DECKSHF then Duel.ShuffleDeck(tp) end
	--[[
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	local t={}
	for i=1,ct do
		t[i]=i
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ANNOUNCESEQ)
	local seq=Duel.AnnounceNumber(tp,table.unpack(t))
	Duel.MoveSequence(sg:GetFirst(),seq)
	]]
end
--[[
	FAQ

	Official FAQ
	* It can go on top of your deck, on the bottom, or anywhere in-between; you can count out a specific place to put it,
	e.g. four cards down.

	Other Rules clarifications
	* Where you put the card is public knowledge.
	http://wiki.dominionstrategy.com/index.php/Secret Passage#FAQ
	
	References
		1. Ancient Telescope
		https://github.com/Fluorohydride/ygopro-scripts/blob/28cfc2d/c17092736.lua#L18
]]
