--Torturer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, choose one (discard hand or gain - to hand)
	aux.AddActionEffect(c,scard.op1)
end
--draw, choose one (discard hand or gain - to hand)
function scard.thfilter(c)
	return c:IsType(TYPE_CURSE) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,3,REASON_EFFECT)
	local sel_list={0x1,0x2}
	local option_list={aux.Stringid(sid,1),aux.Stringid(sid,2)}
	local opt=Duel.SelectOption(1-tp,table.unpack(option_list))+1
	local sel=sel_list[opt]
	if bit.band(sel,0x1)~=0 then
		Duel.DiscardHand(1-tp,aux.TRUE,2,2,REASON_EFFECT+REASON_DISCARD)
	end
	if bit.band(sel,0x2)~=0 then
		local tc=Duel.GetFirstMatchingCard(aux.SupplyFilter(scard.thfilter),1-tp,LOCATION_SUPPLY,LOCATION_SUPPLY,nil)
		Duel.GainCards(tc,REASON_EFFECT,1-tp,LOCATION_HAND)
	end
end
--[[
	FAQ

	Official FAQ
	* A player can choose to gain a Curse even with no Curses left (and thus not gain one), or to discard 2 cards even
	with one or zero cards in hand (discarding their only card if they have one).
	* Gained Curses go to players' hands rather than their discard piles.

	http://wiki.dominionstrategy.com/index.php/Torturer#FAQ
]]
