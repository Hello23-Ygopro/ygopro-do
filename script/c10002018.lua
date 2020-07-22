--Minion
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add action, choose one (add coin or discard hand, draw)
	aux.AddActionEffect(c,scard.op1)
end
--add action, choose one (add coin or discard hand, draw)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local sel_list={0x1,0x2}
	local option_list={aux.Stringid(sid,1),aux.Stringid(sid,2)}
	local opt=Duel.SelectOption(tp,table.unpack(option_list))+1
	local sel=sel_list[opt]
	if bit.band(sel,0x1)~=0 then
		Duel.AddCoin(tp,2)
	end
	if bit.band(sel,0x2)~=0 then
		local g1=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		Duel.SendtoDPile(g1,REASON_EFFECT+REASON_DISCARD,tp)
		Duel.Draw(tp,4,REASON_EFFECT)
		local g2=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
		if g2:GetCount()>=5 then
			Duel.SendtoDPile(g2,REASON_EFFECT+REASON_DISCARD,1-tp)
			Duel.Draw(1-tp,4,REASON_EFFECT)
		end
	end
end
--[[
	FAQ

	Official FAQ
	* A player who Moats this neither discards nor draws.

	Other Rules clarifications
	* You still draw 4 cards if you choose the discard option with no cards left in hand.

	http://wiki.dominionstrategy.com/index.php/Minion#FAQ
]]
