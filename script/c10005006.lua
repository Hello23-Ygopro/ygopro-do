--Bishop
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add coin, add vp, trash
	aux.AddActionEffect(c,scard.op1)
end
--add coin, add vp, trash
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddCoin(tp,1)
	Duel.AddPlayerToken(tp,COUNTER_VP_TOKEN,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
	local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToTrash,tp,LOCATION_HAND,0,1,1,nil)
	if g1:GetCount()>0 and Duel.Trash(g1,REASON_EFFECT,tp)>0 then
		local tc=Duel.GetOperatedCard()
		local cost=tc:GetCost()
		Duel.AddPlayerToken(tp,COUNTER_VP_TOKEN,math.floor(cost/2))
	end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TRASH)
	local g2=Duel.SelectMatchingCard(1-tp,Card.IsAbleToTrash,1-tp,LOCATION_HAND,0,0,1,nil)
	if g2:GetCount()>0 then
		Duel.Trash(g2,REASON_EFFECT,1-tp)
	end
end
--[[
	FAQ

	Official FAQ
	* Trashing a card is optional for the other players but mandatory for you.
	* P and D in costs is ignored, for example if you trash Golem (from Dominion: Alchemy), which costs $4P, you get 3VP
	total.
	* If you have no cards left in hand to trash, you still get the $1 and 1VP.
	http://wiki.dominionstrategy.com/index.php/Bishop#FAQ

	Official Rules

	Prosperity
	* When a player first takes VP tokens, he takes a player mat to put them on.
	* VP tokens are not private; anyone can count them.
	* At the end of the game, players add the VP they have from tokens to their regular score.
	http://wiki.dominionstrategy.com/index.php/VP_token
]]
