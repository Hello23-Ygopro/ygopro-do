--Counting House
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--to hand
	aux.AddActionEffect(c,scard.op1)
end
--to hand
function scard.thfilter(c)
	return c:IsCode(CARD_COPPER) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DPILE,0,0,MAX_NUMBER,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
--[[
	FAQ

	Official FAQ
	* This card lets you look through your discard pile, something you normally are not allowed to do.
	* You only get to look through your discard pile when you play this.
	* You do not have to show the other players your entire discard pile, just the Coppers you take out.
	* After you take out the Coppers, you can leave your discard pile in any order.
	http://wiki.dominionstrategy.com/index.php/Counting_House#FAQ
]]
