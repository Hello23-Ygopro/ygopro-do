--Native Village
--Not fully implemented
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add action, choose one (native village or to hand)
	aux.AddActionEffect(c,scard.op1)
end
--add action, choose one (native village or to hand)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddAction(tp,2)
	local sel_list={0x1,0x2}
	local option_list={aux.Stringid(sid,1),aux.Stringid(sid,2)}
	local opt=Duel.SelectOption(tp,table.unpack(option_list))+1
	local sel=sel_list[opt]
	if bit.band(sel,0x1)~=0 then
		--
	end
	if bit.band(sel,0x2)~=0 then
		--
	end
end
--[[
	FAQ

	Official FAQ
	* You can look at the cards on your mat whenever you like, but other players cannot.
	* You may choose either option even if there are no cards in your deck or no cards on your mat.
	* At the end of the game, all cards from the mat are returned to your deck for scoring.

	Other Rules clarifications
	* If you choose to place the top card of your deck on the Native Village player mat you may then immediately look at
	the card, but your choice has been done.
	http://wiki.dominionstrategy.com/index.php/Native_Village#FAQ
]]
