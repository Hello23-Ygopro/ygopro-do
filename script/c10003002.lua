--Haven
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--draw, add action, set aside
	aux.AddActionEffect(c,scard.op1)
end
--draw, add action, set aside
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.AddAction(tp,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local tc=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
	if not tc then return end
	Duel.SetAside(tc,POS_FACEDOWN,REASON_EFFECT,tp)
	local c=e:GetHandler()
	--duration (to hand)
	local e1=aux.AddDurationEffect(c,tc,aux.DurationCondition,scard.op2)
	e1:SetLabelObject(c)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_ACTION,2)
	aux.SetDurationState(c)
	aux.SetDurationState(tc)
end
--duration (to hand)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SendtoHand(c,tp,REASON_EFFECT)
	--end duration
	e:GetLabelObject():ResetEffect(EFFECT_DONOT_CLEANUP,RESET_CODE)
end
--[[
	FAQ

	Official FAQ
	* First draw a card and get +1 Action; then choose a card from your hand and set it aside face down under Haven.
	* You may look at it, but other players may not.

	* Duration cards are not discarded in Clean-up if they have something left to do; they stay in play until the Clean-up
	of the last turn that they do something.
	* Additionally, if a Duration card is played extra times by a card such as Scepter, that card also stays in play until
	the Duration card is discarded, to track the fact that the Duration card was played extra times.

	Other Rules clarifications
	* If you have no card in your hand to set aside when you play Haven, you set aside nothing, and clean up Haven at the
	end of that turn; it does not stay out.
	* If Haven is still in play when the game ends, it and the card set aside with it are returned to your deck before
	scoring; this can matter for alt-VP cards like Gardens.
	http://wiki.dominionstrategy.com/index.php/Haven#FAQ
	http://wiki.dominionstrategy.com/index.php/Duration
]]
