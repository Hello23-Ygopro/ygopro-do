--King's Court
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--gain effect
	aux.AddActionEffect(c,scard.op1)
end
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAYTHRICE)
	local g=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_HAND,0,1,1,nil,TYPE_ACTION)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	--play thrice
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PLAY_ACTION_THRICE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_INPLAY+RESET_PHASE+PHASE_END)
	g:GetFirst():RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetDescription(DESC_PLAY_THRICE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_INPLAY+RESET_PHASE+PHASE_END)
	g:GetFirst():RegisterEffect(e2)
end
--[[
	FAQ

	Official FAQ
	* This is similar to Throne Room, but plays the Action three times rather than twice.
	* For example if you start a turn by playing King's Court on Village, you would draw a card, get +2 Actions, draw
	another card, get +2 Actions again, draw a 3rd card, and get +2 Actions again, leaving you with 6 Actions.
	* If you King's Court a King's Court, you may play an Action card three times, then may play another Action card three
	times, then may play a 3rd Action card three times; you do not play one Action card nine times.
	http://wiki.dominionstrategy.com/index.php/King%27s_Court#FAQ
]]
