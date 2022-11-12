LinkLuaModifier("modifier_item_standef_talisman", "modifiers/items/modifier_item_standef_talisman", LUA_MODIFIER_MOTION_NONE)

item_standef_talisman = class({})

function item_standef_talisman:GetIntrinsicModifierName()
	return "modifier_item_standef_talisman"
end