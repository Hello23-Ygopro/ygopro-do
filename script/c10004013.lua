--Possession
--Not fully implemented: Cannot make decisions for the opponent 
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddPotionCost(c,1)
	--gain effect
	aux.AddActionEffect(c,scard.op1)
end
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--take extra turn
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SKIP_TURN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN)
	Duel.RegisterEffect(e1,tp)
end
--[[
	FAQ

	Official FAQ
	Other Rules clarifications
	http://wiki.dominionstrategy.com/index.php/Possession#FAQ
]]
