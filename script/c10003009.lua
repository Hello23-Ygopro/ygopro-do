--Smugglers
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--gain
	aux.AddActionEffect(c,scard.op1)
	if not scard.global_check then
		scard.global_check=true
		scard.card_list={}
		--register gain
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CUSTOM+EVENT_GAIN)
		ge1:SetOperation(scard.regop1)
		Duel.RegisterEffect(ge1,0)
		--reset gain
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_TURN_END)
		ge2:SetOperation(scard.rstop1)
		Duel.RegisterEffect(ge2,0)
	end
end
--register gain
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	table.insert(scard.card_list,ec:GetCode())
end
--reset gain
function scard.rstop1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()==tp then
		scard.card_list={}
	end
end
--gain
function scard.gainfilter(c)
	return c:IsCode(table.unpack(scard.card_list)) and c:IsCostBelow(6)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_GAIN)
	local g=Duel.SelectMatchingCard(tp,aux.SupplyFilter(scard.gainfilter),tp,LOCATION_SUPPLY,LOCATION_SUPPLY,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.GainCards(g,REASON_EFFECT,tp)
	end
end
