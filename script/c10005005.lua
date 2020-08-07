--Watchtower
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.AddActionEffect(c,scard.op1)
	--reaction (trash or to deck)
	local e1=aux.AddReactionEffect(c,scard.op2,aux.EventPlayerCondition(PLAYER_SELF))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_CUSTOM+EVENT_GAIN)
end
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=6-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ct>=1 then
		Duel.Draw(tp,ct,REASON_EFFECT)
	end
end
--reaction (trash or to deck)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.ConfirmCards(1-tp,e:GetHandler())
	for ec in aux.Next(eg) do
		local option_list={}
		local sel_list={}
		if ec:IsAbleToTrash() then
			table.insert(option_list,OPTION_TRASH)
			table.insert(sel_list,1)
		end
		if ec:IsAbleToDeck() then
			table.insert(option_list,OPTION_TODECK)
			table.insert(sel_list,2)
		end
		local opt=sel_list[Duel.SelectOption(tp,table.unpack(option_list))+1]
		if opt==1 then
			Duel.Trash(ec,REASON_EFFECT,tp)
		else
			Duel.SendtoDeck(ec,tp,SEQ_DECK_TOP,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,ec)
		end
	end
end
--[[
	FAQ

	Official FAQ
	* Cards trashed with Watchtower were still gained; they were just immediately trashed afterwards.
	* If a gained card is going somewhere other than to your discard pile, such as a card gained with Mine, you can still
	use Watchtower to trash it or put it on your deck.

	Other Rules clarifications
	* Trashing a card with Watchtower does not prevent on-gain effects from happening.
	* Watchtower's topdecking has the same timing as on-gain effects, so for example you could choose to topdeck Death Cart
	before gaining the 2 Ruins.
	http://wiki.dominionstrategy.com/index.php/Watchtower#FAQ
]]
