--Herbalist
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add buy, add coin
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
--add buy, add coin
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddBuy(tp,1)
	Duel.AddCoin(tp,1)
end
--to deck
function scard.tdfilter(c)
	return c:IsType(TYPE_TREASURE) and c:IsAbleToDeck()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_INPLAY)
		and Duel.IsExistingMatchingCard(aux.InPlayFilter(scard.tdfilter),tp,LOCATION_INPLAY,0,1,nil)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.SelectEffectYesNo(tp,e:GetHandler(),YESNOMSG_USEEFFECT) then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,aux.InPlayFilter(scard.tdfilter),tp,LOCATION_INPLAY,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,tp,SEQ_DECK_TOP,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
--[[
	FAQ

	Official FAQ
	* You choose what order to discard cards during Clean-up; so for example if you have Herbalist, Potion, and Alchemist
	in play, you could choose to discard Alchemist first, putting it on top of your deck, then discard Herbalist, and put
	Potion on top of your deck.

	Other Rules clarifications
	* Using Herbalist with Throne Room or King's Court does not allow you to top-deck more than one Treasure per Herbalist
	card. Using Herbalist with Procession doesn't allow you to top-deck any Treasures at all, since you never actually
	discard the Herbalist.
	* Herbalist cannot top-deck Spoils or any Treasure doubled by Counterfeit, as they are no longer in play when Herbalist
	is discarded.
	http://wiki.dominionstrategy.com/index.php/Herbalist#FAQ
]]
