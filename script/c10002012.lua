--Conspirator
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add coin, draw, add action
	aux.AddActionEffect(c,scard.op1)
	if not scard.global_check then
		scard.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHAINING)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(scard.regop1)
		Duel.RegisterEffect(ge1,0)
	end
end
--add coin, draw, add action
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if rp==tp and rc:IsType(TYPE_ACTION) then
		Duel.RegisterFlagEffect(rp,sid,RESET_PHASE+PHASE_END,0,1)
	end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddCoin(tp,2)
	if Duel.GetFlagEffect(tp,sid)>=3 then
		Duel.Draw(tp,1,REASON_EFFECT)
		Duel.AddAction(tp,1)
	end
end
--[[
	FAQ

	Official FAQ
	* This counts Actions played this turn, rather than Action cards in play.
	* For example if you start a turn with Throne Room on a Conspirator, you get +$2 for the first play of Conspirator,
	but +$2 +1 Card +1 Action for the second play of Conspirator. You only have two Action cards in play, but the second
	play of Conspirator is your third Action played this turn.

	Other Rules clarifications
	* Conspirator does count one-shots and other Actions that have been played but left the play area, but does not count
	Durations that are still in play left over from the previous turn, or Reserves called into play that were not played
	this turn.
	* When you play a Band of Misfits or an Overlord, you are playing two actions. The first action is the card itself,
	then the action selected to imitate is the second action played.

	http://wiki.dominionstrategy.com/index.php/Conspirator#FAQ
]]
