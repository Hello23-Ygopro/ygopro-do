--Treasure Map
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--trash, gain (to deck)
	aux.AddActionEffect(c,scard.op1)
end
--trash, gain (to deck)
function scard.trfilter(c)
	return c:IsCode(sid) and c:IsAbleToTrash()
end
function scard.tdfilter(c)
	return c:IsCode(CARD_GOLD) and c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Trash(e:GetHandler(),REASON_EFFECT,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local g=Duel.SelectMatchingCard(tp,scard.trfilter,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 and Duel.Trash(g,REASON_EFFECT,tp)>0 then
		for i=1,4 do
			local tc=Duel.GetFirstMatchingCard(aux.SupplyFilter(scard.tdfilter),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil)
			Duel.GainCards(tc,REASON_EFFECT,tp,LOCATION_DECK)
		end
	end
end
--[[
	FAQ

	Official FAQ
	* If you did not have another copy of Treasure Map in hand, then you just trash the one Treasure Map and nothing else
	happens.
	* If you Throne Room a Treasure Map, you will only trash the first Treasure Map once, and will gain no Golds.

	Other Rules clarifications
	* You gain no Golds when you emulate a Treasure Map.
		* Prior to 2019 Errata playing Band of Misfits or Overlord "as" Treasure Map could gain the Golds.
	http://wiki.dominionstrategy.com/index.php/Treasure_Map#FAQ
]]
