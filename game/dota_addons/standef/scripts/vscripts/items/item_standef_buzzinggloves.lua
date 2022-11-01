LinkLuaModifier("modifier_item_standef_attackspeed_only", "modifiers/items/modifier_item_standef_attackspeed_only", LUA_MODIFIER_MOTION_NONE)

item_standef_buzzinggloves = class({})

function item_standef_buzzinggloves:GetIntrinsicModifierName()
	return "modifier_item_standef_attackspeed_only"
end