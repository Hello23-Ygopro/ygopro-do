--Copper
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCoin(c,1)
	--treasure
	aux.EnableTreasureAttribute(c)
end
