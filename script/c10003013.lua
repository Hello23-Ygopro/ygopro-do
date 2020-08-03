--Island
--Not fully implemented
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddVP(c,2)
	--island
	aux.AddActionEffect(c,scard.op1)
end
--island
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Group.FromCards(e:GetHandler())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g2=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,1,1,nil)
	g1:Merge(g2)
	--
end
--[[
	FAQ

	Official FAQ
	* Island and the set aside card are face up on the mat; anyone can look at them.
	* They stay there until the end of the game, when you return them to your deck and count your score.
	* At the end of the game, all cards from the mat are returned to your deck for scoring.

	Other Rules clarifications
	* If you Procession an Island, you set it aside with a card, then you set aside another card; you do not trash the
	Island because it has already been set aside, but you do gain a card costing $1 more than the Island.
	http://wiki.dominionstrategy.com/index.php/Island#FAQ
]]
