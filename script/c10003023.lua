--Outpost
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--gain effect
	aux.AddActionEffect(c,scard.op1)
	if not scard.global_check then
		scard.global_check=true
		--register outpost
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHAINING)
		ge1:SetOperation(scard.regop1)
		Duel.RegisterEffect(ge1,0)
	end
end
--register outpost
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	if re:GetHandler():IsCode(sid) then
		Duel.RegisterFlagEffect(rp,sid,RESET_PHASE+PHASE_END,0,1)
	end
end
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,sid)==1 and not Duel.IsPlayerAffectedByEffect(1-tp,EFFECT_SKIP_TURN) then
		local c=e:GetHandler()
		--duration (take extra turn)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SKIP_TURN)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(0,1)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		Duel.RegisterEffect(e1,tp)
		--duration (change draw count)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_CHANGE_DRAW_COUNT)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetTargetRange(1,0)
		e2:SetValue(3)
		e2:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e2,tp)
		--end duration
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_TURN_START)
		e3:SetRange(LOCATION_INPLAY)
		e3:SetCountLimit(1)
		e3:SetLabel(Duel.GetTurnCount())
		e3:SetCondition(aux.DurationCondition)
		e3:SetOperation(scard.op2)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_ACTION,3)
		c:RegisterEffect(e3)
		aux.SetDurationState(c)
	end
end
--end duration
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	e:GetHandler():ResetEffect(EFFECT_DONOT_CLEANUP,RESET_CODE)
end
--[[
	FAQ

	Official FAQ
	* Outpost only does anything the first time you play it in a turn, and only if the previous turn was another player's
	(meaning, you are not already taking an extra turn).
	* Except for the smaller starting hand, the extra turn is a normal turn.
	* If you play e.g. Merchant Ship in the same turn as Outpost, the extra turn will be when you get the +$2 from
	Merchant Ship.
	* Extra turns do not count towards the tiebreaker of which tied player had fewer turns.

	Other Rules clarifications
	* Remember that the extra turn is completely normal (if it happens); it is the turn in which you play Outpost which is
	different, in that you only draw three cards during cleanup.
		* This makes Outpost an exception to the basic rule that Duration cards are discarded from play during the Clean-up
		phase of the last turn on which they "do something"; Outpost doesn't do anything on the extra turn it creates, but
		it is not cleaned up until the end of the extra turn regardless.
	* Playing Throne Room (or similar cards) on Outpost would seem to do nothing, but the Throne Room will still have to
	stay out with the Outpost as long as it does.
	* Playing any Outposts beyond the first one on a turn does nothing, and extra Outposts will be discarded from play
	before you take your extra turn.
	* If you buy Mission on the same turn you play Outpost, you can choose whether the Mission turn or the Outpost turn
	happens first; whichever one does will start with a 3 card hand, while the other will start with a 5 card hand.
	http://wiki.dominionstrategy.com/index.php/Outpost#FAQ
]]
