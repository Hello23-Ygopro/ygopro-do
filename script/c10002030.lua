--Courtier
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--confirm, choose one (add action or add buy or add coin or gain)
	aux.AddActionEffect(c,scard.op1)
end
--confirm, choose one (add action or add buy or add coin or gain)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local tc=Duel.SelectMatchingCard(tp,aux.NOT(Card.IsPublic),tp,LOCATION_HAND,0,1,1,nil):GetFirst()
	if not tc then return end
	Duel.ConfirmCards(1-tp,tc)
	Duel.ShuffleHand(tp)
	local ct=tc:GetTypeCount()
	if ct==0 then
		Duel.Hint(HINT_MESSAGE,tp,ERROR_NOBONUSES)
		return
	end
	local sel=0
	for i=1,ct do
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
		Duel.AddAction(tp,1)
	end
	if bit.band(sel,0x2)~=0 then
		Duel.AddBuy(tp,1)
	end
	if bit.band(sel,0x4)~=0 then
		Duel.AddCoin(tp,3)
	end
	if bit.band(sel,0x8)~=0 then
		local tc=Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsCode),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,CARD_GOLD)
		Duel.GainCards(tc,REASON_EFFECT,tp)
	end
end
--[[
	FAQ

	Official FAQ
	* First reveal a card from your hand, then count the types.
	* Then choose one different thing per type the card had; if you revealed a card with two types, you pick two things.

	Other Rules clarifications
	* Revealing a card with four types gives you all bonuses.
	* If you play Courtier and have no cards in hand, you get no bonus.
	* If you play 2 Courtiers (or Throne Room a Courtier), you may reveal the same card the second time and choose the
	same bonuses as before.
	http://wiki.dominionstrategy.com/index.php/Courtier#FAQ

	References
	* Inspector Boarder
	https://github.com/Fluorohydride/ygopro-scripts/blob/a5d2769/c15397015.lua#L58
]]
