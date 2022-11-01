LinkLuaModifier("modifier_item_standef_movespeed_only", "modifiers/items/modifier_item_standef_movespeed_only", LUA_MODIFIER_MOTION_NONE)

item_standef_sandals = class({})

function item_standef_sandals:GetIntrinsicModifierName()
	return "modifier_item_standef_movespeed_only"
end