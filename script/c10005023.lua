--Bank
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCoin(c,0)
	--treasure
	aux.EnableTreasureAttribute(c)
	--change coin
	local e1=aux.AddChangeCoin(c,scard.val1)
	e1:SetCondition(aux.SelfInPlayCondition)
end
--change coin
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(aux.InPlayFilter(Card.IsType),c:GetControler(),LOCATION_INPLAY,0,nil,TYPE_TREASURE)
end
--[[
	FAQ

	Official FAQ
	* If you play two copies of Bank in a row, the second one will be worth $1 more than the first one.
	* Playing more Treasures after Bank will not change how much $ you got from it.

	Other Rules clarifications
	* Example Turn: You play 2 Coppers followed by a Venture. The Venture finds and Plays a Bank which will be worth $4.
	You play another Venture which finds another Bank, which is worth $6 giving you a total of $14 to spend.
	http://wiki.dominionstrategy.com/index.php/Bank#FAQ
]]
