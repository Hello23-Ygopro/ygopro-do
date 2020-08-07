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

	Official Rules

	Prosperity
	* When a player first takes VP tokens, he takes a player mat to put them on.
	* VP tokens are not private; anyone can count them.
	* At the end of the game, players add the VP they have from tokens to their regular score.
	http://wiki.dominionstrategy.com/index.php/VP_token
]]
