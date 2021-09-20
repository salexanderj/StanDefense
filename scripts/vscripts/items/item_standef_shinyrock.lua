LinkLuaModifier("modifier_item_standef_intelligence_only", "modifiers/items/modifier_item_standef_intelligence_only", LUA_MODIFIER_MOTION_NONE)

item_standef_shinyrock = class({})

function item_standef_shinyrock:GetIntrinsicModifierName()
	return "modifier_item_standef_intelligence_only"
end