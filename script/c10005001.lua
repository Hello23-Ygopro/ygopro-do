--Platinum
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCoin(c,5)
	--treasure
	aux.EnableTreasureAttribute(c)
end
