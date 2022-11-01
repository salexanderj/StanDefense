LinkLuaModifier("modifier_item_standef_armor_only", "modifiers/items/modifier_item_standef_armor_only", LUA_MODIFIER_MOTION_NONE)

item_standef_platearmor = class({})

function item_standef_platearmor:GetIntrinsicModifierName()
	return "modifier_item_standef_armor_only"
end