--Woodcutter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add buy, add coin
	aux.AddActionEffect(c,scard.op1)
end
--add buy, add coin
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddBuy(tp,1)
	Duel.AddCoin(tp,2)
end
