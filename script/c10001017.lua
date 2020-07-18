--Gardens
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddVP(c,0)
	--change vp
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_VP)
	e1:SetValue(scard.val1)
	c:RegisterEffect(e1)
end
--change vp
function scard.val1(e,c)
	local ct=Duel.GetCardCount(c:GetControler())
	return math.floor(ct/10)
end
--[[
	FAQ

	Official FAQ
	* For example, if you have 37 cards at the end of the game, each copy of Gardens you have is worth 3VP.
	* Use 8 copies of Gardens in a 2-player game, 12 copies for 3 or more players.

	Other Rules clarifications
	* Cards on your Island mat, Durations still in play at the end of the game, and cards set aside for Haven or
	Inheritance or for any other reason are also counted at the end of the game.

	http://wiki.dominionstrategy.com/index.php/Gardens#FAQ
]]
