--Royal Seal
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCoin(c,2)
	--treasure
	aux.EnableTreasureAttribute(c)
	--gain
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_GAIN)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetCondition(aux.AND(aux.SelfInPlayCondition,aux.EventPlayerCondition(PLAYER_SELF)))
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--gain
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	for ec in aux.Next(eg) do
		if ec:IsAbleToDeck() and Duel.SelectEffectYesNo(tp,e:GetHandler(),YESNOMSG_USEEFFECT) then
			Duel.Hint(HINT_CARD,0,sid)
			Duel.SendtoDeck(ec,tp,SEQ_DECK_TOP,REASON_EFFECT)
		end
	end
end
--[[
	FAQ

	Official FAQ
	* If you gain multiple cards with this in play, this applies to each of them - you could put any or all of them on top
	of your deck.
	* This applies both to cards gained due to being bought, and to cards gained other ways with Royal Seal in play, such
	as with Hoard.

	Other Rules clarifications
	* If Royal Seal is no longer in play when you gain a card, such as because it was trashed with Mint or top-decked with
	Mandarin, you cannot use its ability.
	http://wiki.dominionstrategy.com/index.php/Royal_Seal#FAQ
]]
