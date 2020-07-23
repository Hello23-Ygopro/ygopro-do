--Harem
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCoin(c,2)
	aux.AddVP(c,2)
	--treasure
	aux.EnableTreasureAttribute(c)
end
--[[
	FAQ

	Official FAQ
	* This can be played in your Buy phase like other Treasures, and is worth 2VP at the end of the game.

	http://wiki.dominionstrategy.com/index.php/Harem#FAQ
]]
