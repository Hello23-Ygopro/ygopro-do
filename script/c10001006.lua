--Gold
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCoin(c,3)
	--treasure
	aux.EnableTreasureAttribute(c)
end
