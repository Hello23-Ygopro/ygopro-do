--Throne Room
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--gain effect
	aux.AddActionEffect(c,scard.op1)
end
--gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAYTWICE)
	local g=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_HAND,0,1,1,nil,TYPE_ACTION)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	--play twice
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PLAY_ACTION_TWICE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_INPLAY+RESET_PHASE+PHASE_END)
	g:GetFirst():RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetDescription(DESC_PLAY_TWICE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_INPLAY+RESET_PHASE+PHASE_END)
	g:GetFirst():RegisterEffect(e2)
end
--[[
	FAQ

	Official FAQ
	* Playing an Action card from your hand is optional.
	* If you do play one, you resolve it completely, then play it a second time.
	* You cannot play other cards in-between (unless told to by the card, such as with Vassal or Throne Room itself).
	* Playing Action cards with Throne Room is just like playing Action cards normally, except it does not use up Action
	plays for the turn.
	* For example if you start a turn by playing Throne Room on Village, you would draw a card, get +2 Actions, draw
	another card, and get +2 Actions again, leaving you with 4 Actions.
	* If you Throne Room a Throne Room, you may play an Action card twice, then may play another Action card twice; you
	do not play one Action card four times.

	Other Rules clarifications
	* When you play Throne Room and choose to target a Duration, the Throne Room stays out in play with the Duration
	that it affects. Even if the targeted Duration won't do anything next turn on its second execution (for example, if
	it is a Tactician, the Throne Room still stays out. The Throne Room is always discarded during Clean-up if the
	Duration is also discarded or otherwise has left play (such as being trashed due to Bonfire). If you Throne Room
	a Throne Room which affects a Duration, the top-level Throne Room does not stay in play and gets cleaned up during
	the Clean-up phase of the turn.
	* Remember that Throne Room does NOT "double" a card - it simply makes you play it twice. It may have different
	effects the first and second time it is played, so remember to follow all the instructions on the card fully from top
	to bottom, and then go back and follow them a second time.
	http://wiki.dominionstrategy.com/index.php/Throne_Room#FAQ
]]
