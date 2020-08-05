--Lighthouse
--Not fully implemented: Doesn't prevent opponent from making you gain cards (e.g. Sea Hag)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add action, add coin
	aux.AddActionEffect(c,scard.op1)
end
--add action, add coin
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddAction(tp,1)
	Duel.AddCoin(tp,1)
	local c=e:GetHandler()
	--duration (add coin)
	local e1=aux.AddDurationEffect(c,c,aux.DurationCondition,scard.op2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_ACTION,2)
	--duration (immune)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_INPLAY)
	e2:SetTargetRange(LOCATION_ALL,LOCATION_ALL)
	e2:SetValue(scard.val1)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(DESC_IMMUNE_ATTACK)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e3:SetTargetRange(1,0)
	e3:SetReset(RESET_PHASE+PHASE_ACTION,2)
	Duel.RegisterEffect(e3,tp)
	aux.SetDurationState(c,true)
end
--duration (add coin)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.AddCoin(tp,1)
	--end duration
	aux.SetDurationState(e:GetHandler(),false)
end
--duration (immune)
function scard.val1(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer() and te:IsActiveType(TYPE_ATTACK)
end
--[[
	FAQ

	Official FAQ
	* Also, while Lighthouse is in play, other players' Attack cards do not affect you (even if you want them to).
	* This does not prevent you from using Reactions when other players play Attacks.

	Other Rules clarifications
	* Lighthouse only protects you against Attack cards played while the Lighthouse is in play. Swamp Hag and Haunted
	Woods are Attack cards that affect you at a time other than when they are played, but what matters for Lighthouse is
	whether Lighthouse was in play when the Attack card was played, not whether it's in play when the Attack cards would
	have their effect on you.
	http://wiki.dominionstrategy.com/index.php/Lighthouse#FAQ
]]
