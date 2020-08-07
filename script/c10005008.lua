--Quarry
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCoin(c,1)
	--treasure
	aux.EnableTreasureAttribute(c)
	--cost less
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_COST)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_INPLAY)
	e1:SetTargetRange(LOCATION_ALL,LOCATION_ALL)
	e1:SetCondition(aux.SelfInPlayCondition)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_ACTION))
	e1:SetValue(-2)
	c:RegisterEffect(e1)
	--fix effect not applying when buying
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_ALL)
	e2:SetCountLimit(1)
	e2:SetOperation(scard.op1)
	c:RegisterEffect(e2)
end
--fix effect not applying when buying
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_COST)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_ALL)
	e1:SetTargetRange(LOCATION_ALL,LOCATION_ALL)
	e1:SetCondition(scard.con1)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_ACTION))
	e1:SetValue(-2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_INPLAY)
	c:RegisterEffect(e1)
end
function scard.con1(e)
	return Duel.GetCurrentPhase()==PHASE_BUY and e:GetHandler():IsStatus(STATUS_CHAINING)
end
--[[
	FAQ

	Official FAQ
	* It affects cards everywhere, such as cards in players' hands.

	* If you use Counterfeit on Quarry, costs do not end up reduced at all: the Quarry ends up in the trash, not in the
	play area, so its cost-reducing effect is not active. The same is true if you buy Mint, trashing treasures, or gain
	Mandarin, top-decking treasures, with Quarry in play: costs go back up as soon as Quarry leaves the play area.
	* If you use Crown on Quarry, costs will only be reduced by $2, as there is still only one copy of Quarry in play.
	http://wiki.dominionstrategy.com/index.php/Quarry#FAQ
]]
