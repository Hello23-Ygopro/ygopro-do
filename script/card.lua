--Overwritten Card functions
--get a card's current cost
--Note: Overwritten to check for the correct cost value if it is changed while the card is not in LOCATION_MZONE
local card_get_level=Card.GetLevel
function Card.GetLevel(c)
	local res=c:GetOriginalCost()
	local t1={c:IsHasEffect(EFFECT_UPDATE_COST)}
	for _,te1 in pairs(t1) do
		res=res+te1:GetValue()
	end
	local t2={c:IsHasEffect(EFFECT_CHANGE_COST)}
	for _,te2 in pairs(t2) do
		res=te2:GetValue()
	end
	return res
end
Card.GetCost=Card.GetLevel
--check if a card's cost is equal to a given value
--Note: See Card.GetCost
local card_is_level=Card.IsLevel
function Card.IsLevel(c,lv)
	return c:GetLevel()==lv
end
Card.IsCost=Card.IsLevel
--check if a card's cost is less than or equal to a given value
--Note: See Card.GetCost
local card_is_level_below=Card.IsLevelBelow
function Card.IsLevelBelow(c,lv)
	return c:GetLevel()<=lv
end
Card.IsCostBelow=Card.IsLevelBelow
--check if a card's cost is greater than or equal to a given value
--Note: See Card.GetCost
local card_is_level_above=Card.IsLevelAbove
function Card.IsLevelAbove(c,lv)
	return c:GetLevel()>=lv
end
Card.IsCostAbove=Card.IsLevelAbove
--New Card functions
--get the amount of coins a card is worth
function Card.GetCoin(c)
	local res=c.coin or 0
	return res
end
--get the amount of victory points a card is worth
function Card.GetVP(c)
	local res=c.vp or 0
	local t={c:IsHasEffect(EFFECT_CHANGE_VP)}
	for _,te in pairs(t) do
		if type(te:GetValue())=="function" then
			res=te:GetValue()(te,c)
		else
			res=te:GetValue()
		end
	end
	return res
end
--check if a card has victory points
function Card.IsHasVP(c)
	return c.vp
end
--get the number of card types a card has
function Card.GetTypeCount(c)
	local res=0
	for i,type in ipairs(aux.type_list) do
		if c:IsType(type) then
			res=res+1
		end
	end
	return res
end
--check if a card can be cleaned up
function Card.IsCanBeCleanedUp(c)
	return not c:IsHasEffect(EFFECT_DONOT_CLEANUP)
end
--Renamed Card functions
--get a card's original cost
Card.GetOriginalCost=Card.GetOriginalLevel
--check if a card can be put in the discard pile
Card.IsAbleToDPile=Card.IsAbleToGrave
--check if a card can be trashed
Card.IsAbleToTrash=Card.IsAbleToRemove
--check if a card can be set aside
Card.IsAbleToSetAside=Card.IsAbleToRemove
