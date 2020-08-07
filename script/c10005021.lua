--Grand Market
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, add buy, add coin
	aux.AddActionEffect(c,scard.op1)
	--cannot be bought
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_BOUGHT)
	e1:SetCondition(scard.con1)
	c:RegisterEffect(e1)
end
--draw, add action, add buy, add coin
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
	Duel.AddBuy(tp,1)
	Duel.AddCoin(tp,2)
end
--cannot be bought
function scard.con1(e)
	return Duel.IsExistingMatchingCard(aux.InPlayFilter(Card.IsCode),e:GetHandlerPlayer(),LOCATION_INPLAY,0,1,nil,CARD_COPPER)
end
--[[
	FAQ

	Official FAQ
	* Coppers that were in play earlier in the turn but aren't anymore also do not stop you; if you have 11 Coppers in play
	and 2 Buys, you could buy a Mint, trash all of your played Treasures, and then buy a Grand Market.
	* You can gain Grand Market other ways - for example with Expand - whether or not you have Coppers in play.
	Other Rules clarifications
	* Remember you cannot play more Treasures after buying a card.
	http://wiki.dominionstrategy.com/index.php/Grand_Market#FAQ
]]
