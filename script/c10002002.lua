--Pawn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--choose two (draw or add action or add buy or add coin)
	aux.AddActionEffect(c,scard.op1)
end
--choose two (draw or add action or add buy or add coin)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local sel=0
	for i=1,2 do
		local sel_list={}
		local option_list={}
		if bit.band(sel,0x1)==0 then
			table.insert(sel_list,0x1)
			table.insert(option_list,aux.Stringid(sid,1))
		end
		if bit.band(sel,0x2)==0 then
			table.insert(sel_list,0x2)
			table.insert(option_list,aux.Stringid(sid,2))
		end
		if bit.band(sel,0x4)==0 then
			table.insert(sel_list,0x4)
			table.insert(option_list,aux.Stringid(sid,3))
		end
		if bit.band(sel,0x8)==0 then
			table.insert(sel_list,0x8)
			table.insert(option_list,aux.Stringid(sid,4))
		end
		local opt=Duel.SelectOption(tp,table.unpack(option_list))+1
		sel=sel+sel_list[opt]
	end
	if bit.band(sel,0x1)~=0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
	if bit.band(sel,0x2)~=0 then
		Duel.AddAction(tp,1)
	end
	if bit.band(sel,0x4)~=0 then
		Duel.AddBuy(tp,1)
	end
	if bit.band(sel,0x8)~=0 then
		Duel.AddCoin(tp,1)
	end
end
--[[
	FAQ

	Other Rules clarifications
	* If Pawn is Throne Roomed King's Courted, the choices do not have to be the same for each play of Pawn.

	http://wiki.dominionstrategy.com/index.php/Pawn#FAQ

	References
		1. Primathmech Laplacian
]]
