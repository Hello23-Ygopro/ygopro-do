--Duke
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddVP(c,0)
	--change vp
	aux.AddChangeVP(c,scard.val1)
end
--change vp
function scard.val1(e,c)
	local g=Duel.GetAllCards(c:GetControler()):Filter(Card.IsCode,nil,CARD_DUCHY)
	return g:GetCount()
end
--[[
	FAQ

	Official FAQ
	* For example, if you have five Duchies, then each of your Dukes is worth 5VP.

	http://wiki.dominionstrategy.com/index.php/Duke#FAQ
]]
