--Lurker
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--add action, choose one (trash or gain)
	aux.AddActionEffect(c,scard.op1)
end
--add action, choose one (trash or gain)
function scard.trfilter(c)
	return c:IsType(TYPE_ACTION) and c:IsAbleToTrash()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AddAction(tp,1)
	local sel_list={0x1,0x2}
	local option_list={aux.Stringid(sid,1),aux.Stringid(sid,2)}
	local opt=Duel.SelectOption(tp,table.unpack(option_list))+1
	local sel=sel_list[opt]
	if bit.band(sel,0x1)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TRASH)
		local g=Duel.SelectMatchingCard(tp,aux.SupplyFilter(scard.trfilter),0,LOCATION_SUPPLY,LOCATION_SUPPLY,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.Trash(g,REASON_EFFECT,tp)
		end
	end
	if bit.band(sel,0x2)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_GAIN)
		local g=Duel.SelectMatchingCard(tp,aux.SupplyFilter(Card.IsType),0,LOCATION_SUPPLY,LOCATION_SUPPLY,1,1,nil,TYPE_ACTION)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.GainCards(g,REASON_EFFECT,tp)
		end
	end
end
