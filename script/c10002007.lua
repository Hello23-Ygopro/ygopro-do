--Steward
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--choose one (draw or add coin or trash)
	aux.AddActionEffect(c,scard.op1)
end
--choose one (draw or add coin or trash)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local sel_list={0x1,0x2,0x4}
	local option_list={aux.Stringid(sid,1),aux.Stringid(sid,2),aux.Stringid(sid,3)}
	local opt=Duel.SelectOption(tp,table.unpack(option_list))+1
	local sel=sel_list[opt]
	if bit.band(sel,0x1)~=0 then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
	if bit.band(sel,0x2)~=0 then
		Duel.AddCoin(tp,2)
	end
	if bit.band(sel,0x4)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToTrash,tp,LOCATION_HAND,0,2,2,nil)
		if g:GetCount()>0 then
			Duel.Trash(g,REASON_EFFECT,tp)
		end
	end
end
--[[
	FAQ

	Official FAQ
	* If you pick "trash 2 cards from your hand" and only have one card in hand, you trash that card; if you choose that
	option and have 2 or more cards in hand, you have to trash 2.

	http://wiki.dominionstrategy.com/index.php/Steward#FAQ

	Additional Rules
	* When a card gives you a choice ("choose one..."), you can pick any option, without considering whether or not you
	will be able to do it.
]]
