--Contraband
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCoin(c,3)
	--treasure
	aux.EnableTreasureAttribute(c)
	--add buy, gain effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_PLAY)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--add buy, gain effect
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.AddBuy(tp,1)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ANNOUNCENAME)
	local code=Duel.AnnounceCard(1-tp)
	local g=Duel.GetMatchingGroup(aux.SupplyFilter(Card.IsCode),0,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,code)
	Duel.HintSelection(g)
	--cannot be bought
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_BOUGHT)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetTargetRange(LOCATION_SUPPLY,LOCATION_SUPPLY)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsCode,code))
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetDescription(DESC_CANNOT_BE_BOUGHT)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e2:SetReset(RESET_PHASE+PHASE_END)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e3:SetTargetRange(LOCATION_SUPPLY,LOCATION_SUPPLY)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsCode,code))
	e3:SetLabelObject(e2)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,0)
end
--[[
	FAQ

	Official FAQ
	* When you play this, you get $3 and +1 Buy.
	* The player to your left names a card, and you cannot buy the named card this turn.
	* This does not stop you from gaining the card in ways other than buying it (such as via Hoard).
	* They do not have to name a card in the Supply.
	* If you play Contraband before other Treasures, you hide how much $ you will have; however the number of cards left in
	a player's hand is public information.
	http://wiki.dominionstrategy.com/index.php/Contraband#FAQ
]]
