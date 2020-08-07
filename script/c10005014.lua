--Mint
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm, gain
	aux.AddActionEffect(c,scard.op1)
	--trash
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_BUY)
	e1:SetOperation(scard.op2)
	c:RegisterEffect(e1)
end
--confirm, gain
function scard.conffilter(c)
	return c:IsType(TYPE_TREASURE) and not c:IsPublic()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if g:IsExists(scard.conffilter,1,nil) and Duel.SelectYesNo(tp,YESNOMSG_CONFIRMHAND) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local sg=g:FilterSelect(tp,scard.conffilter,1,1,nil)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
		local code=sg:GetFirst():GetCode()
		local tc=Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsCode),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,code)
		Duel.GainCards(tc,REASON_EFFECT,tp,LOCATION_HAND)
	end
end
--trash
function scard.trfilter(c)
	return c:IsType(TYPE_TREASURE) and c:IsAbleToTrash()
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	local g=Duel.GetMatchingGroup(aux.InPlayFilter(scard.trfilter),tp,LOCATION_INPLAY,0,nil)
	if g:GetCount()>0 then
		Duel.Trash(g,REASON_EFFECT,tp)
	end
end
