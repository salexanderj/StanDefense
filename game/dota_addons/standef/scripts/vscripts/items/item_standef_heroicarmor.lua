LinkLuaModifier("modifier_item_standef_heroicarmor", "modifiers/items/modifier_item_standef_heroicarmor", LUA_MODIFIER_MOTION_NONE)

item_standef_heroicarmor = class({})

function item_standef_heroicarmor:GetIntrinsicModifierName()
	return "modifier_item_standef_heroicarmor"
end