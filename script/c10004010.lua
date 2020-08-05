--Philosopher's Stone
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCoin(c,0)
	aux.AddPotionCost(c,1)
	--treasure
	aux.EnableTreasureAttribute(c)
	--change coin
	local e1=aux.AddChangeCoin(c,scard.val1)
	e1:SetCondition(aux.SelfInPlayCondition)
end
--change coin
function scard.val1(e,c)
	local ct=Duel.GetFieldGroupCount(c:GetControler(),LOCATION_DECK+LOCATION_DPILE,0)
	return math.floor(ct/5)
end
--[[
	FAQ

	Official FAQ
	* When you play this, count the number of cards in your deck and discard pile combined, divide by 5, and round down.
	That is how many $ this produces for you.
	* Once played, the amount of $ you got does not change even if the number of cards changes later in the turn.
	http://wiki.dominionstrategy.com/index.php/Philosopher%27s_Stone#FAQ
]]
