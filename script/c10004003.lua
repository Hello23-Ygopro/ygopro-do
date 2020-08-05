--Vineyard
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddPotionCost(c,1)
	aux.AddVP(c,0)
	--change vp
	aux.AddChangeVP(c,scard.val1)
end
--change vp
function scard.val1(e,c)
	local g=Duel.GetAllCards(c:GetControler())
	local ct=g:FilterCount(Card.IsType,nil,TYPE_ACTION)
	return math.floor(ct/3)
end
--[[
	FAQ

	Official FAQ
	* This is worth 1VP per 3 Action cards you have, rounded down; for example if you have 11 Action cards, your Vineyards
	are worth 3VP each.

	Other Rules clarifications
	* Cards with multiple types, one of which is Action, are Actions and so are counted by Vineyard.
	http://wiki.dominionstrategy.com/index.php/Vineyard#FAQ
]]
