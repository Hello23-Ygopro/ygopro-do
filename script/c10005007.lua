--Monument
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add coin, add vp
	aux.AddActionEffect(c,scard.op1)
end
--add coin, add vp
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddCoin(tp,2)
	Duel.AddPlayerToken(tp,COUNTER_VP_TOKEN,1)
end
--[[
	FAQ

	Official FAQ
	* You get +$2 and take a VP token.
	http://wiki.dominionstrategy.com/index.php/Monument#FAQ
]]
