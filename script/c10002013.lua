--Coppersmith
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--gain effect
	aux.AddActionEffect(c,scard.op1)
end
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--increase copper produce
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_COPPER_PRODUCE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,Duel.GetTurnPlayer())
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetDescription(DESC_MORE_COPPER)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e2:SetTargetRange(1,0)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,Duel.GetTurnPlayer())
end
--[[
	FAQ

	Official FAQ
	* This just changes how much money you get when playing Copper.
	* The effect is cumulative; if you use Throne Room on Coppersmith, each Copper that you play that turn will produce
	$3.

	Other Rules clarifications
	* The bonus value does not apply retroactively to Coppers in play before playing the Coppersmith (via Black Market
	or Storyteller).
	http://wiki.dominionstrategy.com/index.php/Coppersmith#FAQ
]]
