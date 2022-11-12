LinkLuaModifier("modifier_item_standef_wolfpelt", "modifiers/items/modifier_item_standef_wolfpelt", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_standef_wolfpelt_active", "modifiers/items/modifier_item_standef_wolfpelt_active", LUA_MODIFIER_MOTION_NONE)

item_standef_wolfpelt = class({})

function item_standef_wolfpelt:GetIntrinsicModifierName()
	return "modifier_item_standef_wolfpelt"
end

function item_standef_wolfpelt:OnSpellStart()
	
	if not IsServer() then return end

	local eCaster = self:GetCaster()
	local fDuration = self:GetSpecialValueFor("duration")

	eCaster:AddNewModifier(eCaster, self, "modifier_item_standef_wolfpelt_active", {duration = fDuration})
	EmitSoundOn("DOTA_Item.Butterfly", eCaster)
end
