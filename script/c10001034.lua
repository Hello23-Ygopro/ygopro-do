--Merchant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, gain effect
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action, gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
	--add coin
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
--add coin
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if rp==tp and rc:IsCode(CARD_SILVER) then
		Duel.Hint(HINT_CARD,0,sid)
		Duel.AddCoin(tp,1)
	end
end
--[[
	FAQ

	Other Rules clarifications
	* Playing Throne Room on Merchant will give you +$2 when you play your first Silver.
	http://wiki.dominionstrategy.com/index.php/Merchant#FAQ
]]
