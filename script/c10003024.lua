--Tactician
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--discard hand
	aux.AddActionEffect(c,scard.op1)
end
--discard hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD,tp)
	local c=e:GetHandler()
	--duration (draw, add action, add buy)
	local e1=aux.AddDurationEffect(c,c,aux.DurationCondition,scard.op2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_ACTION,3)
	aux.SetDurationState(c)
end
--duration (draw, add action, add buy)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Draw(tp,5,REASON_EFFECT)
	Duel.AddAction(tp,1)
	Duel.AddBuy(tp,1)
	--end duration
	aux.RemoveDurationState(e:GetHandler())
end
--[[
	FAQ

	Official FAQ
	* If you have no cards in hand, then Tactician does nothing more and is discarded in the same turn's Clean-up.
	* If you do have at least one card, you discard your hand, Tactician stays in play, and at the start of your next turn
	you get +5 Cards, +1 Buy, and +1 Action (and Tactician is discarded that turn).
	* If you use Throne Room on Tactician, you will discard your hand on the first play and will have no cards in hand for
	the second play (and so will not get the bonuses from it).

	Other Rules clarifications
	* You can Throne Room a Tactician, but (without a +1 Card token) you do not get any extra cards (as described above).
	Still the Throne Room (or its variants) stays in play.
	* Like all Duration cards, Tactician only stays in play during your Clean-up phase if it will do something in a future
	turn. So, if you play Tactician but do not discard any cards, it will have no effect on your next turn and should be
	discarded during the same turn's Clean-up phase.
	* When the +1 Card token is on Tactician, using a Throne Room variant on it becomes meaningful as it provides you a
	card to discard each time Tactician is played again.
	http://wiki.dominionstrategy.com/index.php/Tactician#FAQ
]]
