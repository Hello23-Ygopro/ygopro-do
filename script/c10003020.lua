--Explorer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm, gain (to hand)
	aux.AddActionEffect(c,scard.op1)
end
--confirm, gain (to hand)
function scard.conffilter(c)
	return c:IsCode(CARD_PROVINCE) and not c:IsPublic()
end
function scard.thfilter(c,code)
	return c:IsCode(code) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if g:IsExists(scard.conffilter,1,nil) and Duel.SelectYesNo(tp,YESNOMSG_CONFIRMHAND) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local sg=g:FilterSelect(tp,scard.conffilter,1,1,nil)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
		local tc=Duel.GetFirstMatchingCard(aux.SupplyFilter(scard.thfilter),tp,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,CARD_GOLD)
		Duel.GainCards(tc,REASON_EFFECT,tp,LOCATION_HAND)
	else
		local tc=Duel.GetFirstMatchingCard(aux.SupplyFilter(scard.thfilter),tp,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,CARD_SILVER)
		Duel.GainCards(tc,REASON_EFFECT,tp,LOCATION_HAND)
	end
end
