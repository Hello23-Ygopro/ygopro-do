--Merchant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, add coin
	aux.AddActionEffect(c,scard.op1)
	if not scard.global_check then
		scard.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHAINING)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(scard.regop1)
		Duel.RegisterEffect(ge1,0)
	end
end
--draw, add action, add coin
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if rp==tp and rc:IsCode(CARD_SILVER) then
		Duel.RegisterFlagEffect(rp,sid,RESET_PHASE+PHASE_END,0,1)
	end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
	if Duel.GetFlagEffect(tp,sid)==1 then
		Duel.AddCoin(tp,1)
	end
end
--[[
	FAQ

	Other Rules clarifications
	* Playing Throne Room on Merchant will give you +$2 when you play your first Silver.

	http://wiki.dominionstrategy.com/index.php/Merchant#FAQ
]]
