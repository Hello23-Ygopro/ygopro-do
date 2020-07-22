--Nobles
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddVP(c,2)
	--choose one (draw or add action)
	aux.AddActionEffect(c,scard.op1)
end
--choose one (draw or add action)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local sel_list={0x1,0x2}
	local option_list={aux.Stringid(sid,1),aux.Stringid(sid,2)}
	local opt=Duel.SelectOption(tp,table.unpack(option_list))+1
	local sel=sel_list[opt]
	if bit.band(sel,0x1)~=0 then
		Duel.Draw(tp,3,REASON_EFFECT)
	end
	if bit.band(sel,0x2)~=0 then
		Duel.AddCoin(tp,2)
	end
end
