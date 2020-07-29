--Bridge
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add buy, add coin, gain effect
	aux.AddActionEffect(c,scard.op1)
end
--add buy, add coin, gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddBuy(tp,1)
	Duel.AddCoin(tp,1)
	local g=Duel.GetAllCards()
	for tc in aux.Next(g) do
		--cost less
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_COST)
		e1:SetValue(-1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
--[[
	FAQ

	Official FAQ
	* All cards, including cards in the Supply, in play, in decks, and in hands, cost $1 less for the rest of this turn,
	but not less than $0.
	* This is cumulative; if you play two Bridges (or the same Bridge twice via Throne Room), cards will cost $2 less.
	http://wiki.dominionstrategy.com/index.php/Bridge#FAQ

	References
	* Cost Down
	https://github.com/Fluorohydride/ygopro-scripts/blob/2c4f0ca/c23265313.lua#L22
]]
