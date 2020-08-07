--Hoard
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCoin(c,2)
	--treasure
	aux.EnableTreasureAttribute(c)
	--gain
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_BUY)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCondition(aux.AND(aux.SelfInPlayCondition,aux.EventPlayerCondition(PLAYER_SELF),scard.con1))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--gain
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsType,1,nil,TYPE_VICTORY)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	for i=1,eg:GetCount() do
		local tc=Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsCode),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,CARD_GOLD)
		Duel.Hint(HINT_CARD,0,sid)
		Duel.GainCards(tc,REASON_EFFECT,tp)
	end
end
--[[
	FAQ

	Official FAQ
	* If you buy multiple Victory cards, you will get Gold for each one.
	* Victory cards gained other than via buying them do not get you Gold.

	Other Rules clarifications
	* A Crowned Hoard will still only gain one Gold per Victory card buy.
	http://wiki.dominionstrategy.com/index.php/Hoard#FAQ
	http://wiki.dominionstrategy.com/index.php/Crown
]]
