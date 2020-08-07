--Mountebank
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add coin, discard hand or gain
	aux.AddActionEffect(c,scard.op1)
end
--add coin, discard hand or gain
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddCoin(tp,2)
	if Duel.IsExistingMatchingCard(Card.IsType,tp,0,LOCATION_HAND,1,nil,TYPE_CURSE)
		and Duel.SelectYesNo(1-tp,YESNOMSG_DISCARDHAND) then
		Duel.DiscardHand(1-tp,Card.IsType,1,1,REASON_EFFECT+REASON_DISCARD,nil,TYPE_CURSE)
	else
		local tc1=Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsType),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,TYPE_CURSE)
		local tc2=Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsCode),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,CARD_COPPER)
		Duel.GainCards(Group.FromCards(tc1,tc2),REASON_EFFECT,1-tp)
	end
end
