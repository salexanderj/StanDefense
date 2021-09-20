LinkLuaModifier("modifier_item_standef_strength_only", "modifiers/items/modifier_item_standef_strength_only", LUA_MODIFIER_MOTION_NONE)

item_standef_redring = class({})

function item_standef_redring:GetIntrinsicModifierName()
	return "modifier_item_standef_strength_only"
end