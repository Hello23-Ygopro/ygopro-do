--Talisman
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCoin(c,1)
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
function scard.cfilter(c)
	return not c:IsType(TYPE_VICTORY) and c:IsCostBelow(4)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	for ec in aux.Next(eg) do
		local code=ec:GetCode()
		local tc=Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsCode),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,code)
		Duel.Hint(HINT_CARD,0,sid)
		Duel.GainCards(tc,REASON_EFFECT,tp)
	end
end
--[[
	FAQ

	Official FAQ
	* Each time you buy a non-Victory card costing $4 or less with this in play, you gain another copy of the bought card.
	* If there are no copies left, you do not gain one.
	* If you have multiple Talismans, you gain an additional copy for each one; if you buy multiple cards for $4 or less,
	Talisman applies to each one.
	* Talisman only affects buying cards; it does not work on cards gained other ways, such as with Expand.

	Other Rules clarifications
	* When you buy a card from the Black Market deck, you do not get a second copy of it even if Talisman is in play, since
	there is no second copy in the Supply.
	* Talisman, like most other gainers, cannot be used to gain cards with P or D in their cost.
	http://wiki.dominionstrategy.com/index.php/Talisman#FAQ
]]
