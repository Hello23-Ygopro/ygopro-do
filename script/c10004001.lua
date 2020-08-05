--Potion
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddPotion(c,1)
	--treasure
	aux.EnableTreasureAttribute(c)
end
--[[
	FAQ

	Official FAQ
	* This is a basic Treasure card. It costs $4 and produces P.
	* It is not a Kingdom card; see the Preparation rules.
	http://wiki.dominionstrategy.com/index.php/Potion#FAQ
]]
