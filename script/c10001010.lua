--Moat
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw
	aux.AddActionEffect(c,scard.op1)
	--reaction (get effect)
	aux.AddReactionEffect(c,scard.op2,aux.ReactionCondition)
end
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
end
--reaction (get effect)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.ConfirmCards(1-tp,c)
	--immune
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_PUBLIC)
	e0:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_HAND)
	e1:SetValue(scard.val1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
function scard.val1(e,te,c)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer() and c~=te:GetHandler()
end
--[[
	FAQ

	Official FAQ
	* When another player plays an Attack card, you may reveal a Moat from your hand, before the Attack does anything, to
	be unaffected by the Attack - you do not reveal cards to Bandit, or put a Victory card on your deck for Bureaucrat,
	or discard for Militia, or gain a Curse for Witch.
	* Moat stays in your hand, and can still be played on your next turn.
	* Moat does not stop anything an Attack does to other players, or for the player who played it; it just protects you
	personally.
	* If multiple Attacks are played on a turn or in a round of turns, you may reveal Moat for as many of them as you
	want.

	Other Rules clarifications
	* Using a Moat to block an Attack does not give you +2 cards at the time; you only get the +2 cards when you play the
	Moat during the Action phase of your own turn.
	* You can only reveal Moat when an Attack card is played, not when it is bought or gained, even if it affects you at
	that time.
	* If an Attack card allows the player who played it to make a decision, like Minion or Pirate Ship, you must decide
	whether to reveal Moat before the player decides what function of the Attack card to use.

	http://wiki.dominionstrategy.com/index.php/Moat#FAQ
]]
