--Pirate Ship
--Not fully implemented
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--choose one (add coin or trash, discard deck, add token)
	aux.AddActionEffect(c,scard.op1)
end
--choose one (add coin or trash, discard deck, add token)
function scard.trfilter(c)
	return c:IsType(TYPE_TREASURE) and c:IsAbleToTrash()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local sel_list={0x1,0x2}
	local option_list={aux.Stringid(sid,1),aux.Stringid(sid,2)}
	local opt=Duel.SelectOption(tp,table.unpack(option_list))+1
	local sel=sel_list[opt]
	if bit.band(sel,0x1)~=0 then
		--
	end
	if bit.band(sel,0x2)~=0 then
		Duel.ConfirmDecktop(1-tp,2)
		local g1=Duel.GetDecktopGroup(1-tp,2)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
		local sg=g1:FilterSelect(tp,scard.trfilter,1,1,nil)
		Duel.DisableShuffleCheck()
		g1:Sub(sg)
		if sg:GetCount()>0 then
			Duel.Trash(sg,REASON_EFFECT,1-tp)
		end
		if g1:GetCount()>0 then
			Duel.SendtoDPile(g1,REASON_EFFECT+REASON_DISCARD,1-tp)
		end
		local g2=Duel.GetOperatedGroup()
		if g2:IsExists(Card.IsLocation,1,nil,LOCATION_TRASH) then
			--
		end
	end
end
--[[
	FAQ

	Official FAQ
	* Players revealing a card like Moat do so before you choose your option.
	* You get at most one Coin token per play of Pirate Ship.
	* Coin tokens on your Pirate Ship mat cannot be spent (as the Coin tokens from Dominion: Guilds can be).
	http://wiki.dominionstrategy.com/index.php/Pirate_Ship#FAQ
]]
