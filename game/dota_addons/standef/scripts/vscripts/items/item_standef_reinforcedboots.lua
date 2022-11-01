LinkLuaModifier("modifier_item_standef_movespeed_only", "modifiers/items/modifier_item_standef_movespeed_only", LUA_MODIFIER_MOTION_NONE)

item_standef_reinforcedboots = class({})

function item_standef_reinforcedboots:GetIntrinsicModifierName()
	return "modifier_item_standef_movespeed_only"
end