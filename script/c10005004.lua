--Trade Route
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add buy, trash, add coin
	aux.AddActionEffect(c,scard.op1)
	--setup (add token)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_SETUP)
	e1:SetRange(LOCATION_SUPPLY)
	e1:SetCountLimit(1)
	e1:SetOperation(scard.op2)
	c:RegisterEffect(e1)
end
--add buy, trash, add coin
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddBuy(tp,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToTrash,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.Trash(g,REASON_EFFECT,tp)
	end
	local ct=Duel.GetTokens(tp,COUNTER_COIN_TOKEN_TR)
	Duel.AddCoin(tp,ct)
end
--setup (add token)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	local g=Duel.GetMatchingGroup(aux.SupplyFilter(Card.IsType),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,TYPE_VICTORY)
	Duel.AddSupplyToken(g,COUNTER_COIN_TOKEN_TR,1)
	--move token
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_GAIN)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op3)
	Duel.RegisterEffect(e1,tp)
end
--move token
function scard.cfilter(c)
	return c:GetCounter(COUNTER_COIN_TOKEN_TR)>0
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,nil)
end
function scard.op3(e,tp,eg,ep,ev,re,r,rp)
	for ec in aux.Next(eg) do
		Duel.Hint(HINT_CARD,0,sid)
		ec:RemoveCounter(tp,COUNTER_COIN_TOKEN_TR,1,REASON_EFFECT)
		Duel.AddPlayerToken(tp,COUNTER_COIN_TOKEN_TR,1)
		Duel.AddPlayerToken(1-tp,COUNTER_COIN_TOKEN_TR,1)
	end
end
--[[
	FAQ

	Official FAQ
	* You get +1 Buy, and trash a card from your hand if you can.
	* Then you get +$1 per Coin token on the Trade Route mat.
	* This card has setup; at the start of games using it, you put a Coin token on each Victory card pile being used
	(including Kingdom card piles such as Gardens, and Colonies if used).
	* In the rare cases where there are more than 8 Victory piles, the tokens are not counter-limited; use a replacement.
	* Whenever any player gains the first card from a Victory card pile - whether by buying it or otherwise gaining it -
	the Coin token is moved to the mat.
	* So if no Victory cards have been gained this game, the mat has no tokens and Trade Route makes +$0; if four Provinces
	and one Estate have been gained, the mat has two tokens and Trade Route makes +$2.
	* If you are using the promotional card Black Market, and Trade Route is in the Black Market deck, you do the setup for
	Trade Route.

	Other Rules clarifications
	* Although Dame Josephine is a Victory card, gaining her does not add a token to the Trade Route mat.
	* The Trade Route token on a pile will not move when...
		* Trashing a Victory card with Salt the Earth.
		* Exiling an Estate with Way of the Worm.
	http://wiki.dominionstrategy.com/index.php/Trade_Route#FAQ
]]
