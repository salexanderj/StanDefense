LinkLuaModifier("modifier_item_standef_energylens", "modifiers/items/modifier_item_standef_energylens", LUA_MODIFIER_MOTION_NONE)

item_standef_energylens = class({})

function item_standef_energylens:GetIntrinsicModifierName()
	return "modifier_item_standef_energylens"
end