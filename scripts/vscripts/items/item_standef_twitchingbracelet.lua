LinkLuaModifier("modifier_item_standef_agility_only", "modifiers/items/modifier_item_standef_agility_only", LUA_MODIFIER_MOTION_NONE)

item_standef_twitchingbracelet = class({})

function item_standef_twitchingbracelet:GetIntrinsicModifierName()
	return "modifier_item_standef_agility_only"
end