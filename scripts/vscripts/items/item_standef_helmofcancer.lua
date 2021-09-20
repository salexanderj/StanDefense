LinkLuaModifier("modifier_item_standef_lifesteal_only", "modifiers/items/modifier_item_standef_lifesteal_only", LUA_MODIFIER_MOTION_NONE)

item_standef_helmofcancer = class({})

function item_standef_helmofcancer:GetIntrinsicModifierName()
	return "modifier_item_standef_lifesteal_only"
end