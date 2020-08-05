--Alchemist
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddPotionCost(c,1)
	--draw, add action
	aux.AddActionEffect(c,scard.op1)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TO_DPILE)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op2)
	c:RegisterEffect(e1)
end
--draw, add action
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	Duel.AddAction(tp,1)
end
--to deck
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_INPLAY) and c:IsAbleToDeck()
		and Duel.IsExistingMatchingCard(aux.InPlayFilter(Card.IsCode),tp,LOCATION_INPLAY,0,1,nil,CARD_POTION)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.SelectEffectYesNo(tp,c,YESNOMSG_USEEFFECT) then
		Duel.Hint(HINT_CARD,0,sid)
		Duel.SendtoDeck(c,tp,SEQ_DECK_TOP,REASON_EFFECT)
	end
end
--[[
	FAQ

	Official FAQ
	* This is optional, and happens before drawing your new hand.
	* If you have multiple Alchemists and a Potion, you can put any or all of the Alchemists on top of your deck.
	* You do not have to have used the Potion to buy anything, you only need to have played it.
	* You choose what order to discard cards in Clean-up, and so can discard your Alchemists ahead of your Potion.

	Other Rules clarifications
	* Remember that you are allowed to play a Potion during your buy phase, like any other Treasure, even if you don't
	intend to or can't buy a card with P in the cost.
	http://wiki.dominionstrategy.com/index.php/Alchemist#FAQ
]]
