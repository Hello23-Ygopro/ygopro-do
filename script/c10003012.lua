--Cutpurse
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add coin, discard hand
	aux.AddActionEffect(c,scard.op1)
end
--add coin, discard hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddCoin(tp,2)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:FilterCount(Card.IsCode,nil,CARD_COPPER)>0 then
		Duel.DiscardHand(1-tp,Card.IsCode,1,1,REASON_EFFECT+REASON_DISCARD,nil,CARD_COPPER)
	else
		Duel.ConfirmCards(tp,g)
		Duel.ShuffleHand(1-tp)
	end
end
