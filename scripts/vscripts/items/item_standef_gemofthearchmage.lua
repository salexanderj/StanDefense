LinkLuaModifier("modifier_item_standef_intelligence_only", "modifiers/items/modifier_item_standef_intelligence_only", LUA_MODIFIER_MOTION_NONE)

item_standef_gemofthemagi = class({})

function item_standef_gemofthemagi:GetIntrinsicModifierName()
	return "modifier_item_standef_intelligence_only"
end