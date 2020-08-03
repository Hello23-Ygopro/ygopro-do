--Embargo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add coin, trash, add token
	aux.AddActionEffect(c,scard.op1)
end
--add coin, trash, add token
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddCoin(tp,2)
	if Duel.Trash(e:GetHandler(),REASON_EFFECT,tp)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ADDTOKEN)
	local g=Duel.SelectMatchingCard(tp,aux.SupplyFilter(),tp,LOCATION_SUPPLY,LOCATION_SUPPLY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.AddToken(g,COUNTER_EMBARGO_TOKEN,1)
	--gain
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_BUY)
	e1:SetOperation(scard.op2)
	Duel.RegisterEffect(e1,tp)
end
--gain
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	for i=1,ec:GetEffectCount(EFFECT_EMBARGO) do
		local tc=Duel.GetFirstMatchingCard(aux.SupplyFilter(Card.IsType),ep,LOCATION_SUPPLY,LOCATION_SUPPLY,nil,TYPE_CURSE)
		Duel.Hint(HINT_CARD,0,sid)
		Duel.GainCards(tc,REASON_EFFECT,ep)
	end
end
--[[
	FAQ

	Official FAQ
	* This is cumulative; with three Embargo tokens on a pile, buying a card from that pile will give you three Curses.
	* Embargo tokens do not do anything if a card is gained without being bought, such as with Smugglers, or if the Curse
	pile is empty.
	* Embargo tokens are not counter-limited; use a replacement if necessary.
	* If you Throne Room Embargo, you will get +$4 and place two tokens, even though you can only trash Embargo once.

	Other Rules clarifications
	* If there are multiple Embargo tokens on a pile, each Curse gain from buying from that pile happens separately, which
	allows other when-buy triggers (such as Haggler's) to activate in between Curse gains.
	http://wiki.dominionstrategy.com/index.php/Embargo#FAQ
]]
