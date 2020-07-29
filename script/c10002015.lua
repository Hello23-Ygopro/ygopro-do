--Mining Village
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, trash, add coin
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action, trash, add coin
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,2)
	local c=e:GetHandler()
	if not c:IsAbleToTrash() or not Duel.SelectYesNo(tp,YESNOMSG_TRASH) then return end
	if Duel.Trash(c,REASON_EFFECT,tp)>0 then
		Duel.AddCoin(tp,2)
	end
end
--[[
	FAQ

	Official FAQ
	* If you Throne Room a Mining Village, you cannot trash it twice (and so cannot get the +$2 twice).
	http://wiki.dominionstrategy.com/index.php/Mining_Village#FAQ

	References
	* Judgment of Anubis
	https://github.com/Fluorohydride/ygopro-scripts/blob/c96a760/c55256016.lua#L43
]]
