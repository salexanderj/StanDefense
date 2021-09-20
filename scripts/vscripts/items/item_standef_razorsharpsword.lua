LinkLuaModifier("modifier_item_standef_damage_only", "modifiers/items/modifier_item_standef_damage_only", LUA_MODIFIER_MOTION_NONE)

item_standef_razorsharpsword = class({})

function item_standef_razorsharpsword:GetIntrinsicModifierName()
	return "modifier_item_standef_damage_only"
end