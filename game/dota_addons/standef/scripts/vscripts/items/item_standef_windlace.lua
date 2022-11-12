LinkLuaModifier("modifier_item_standef_windlace", "modifiers/items/modifier_item_standef_windlace", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_standef_windlace_active", "modifiers/items/modifier_item_standef_windlace_active", LUA_MODIFIER_MOTION_NONE)

item_standef_windlace = class({})

function item_standef_windlace:GetIntrinsicModifierName()
	return "modifier_item_standef_windlace"
end

function item_standef_windlace:OnSpellStart()
	
	if not IsServer() then return end

	local eCaster = self:GetCaster()
	local fDuration = self:GetSpecialValueFor("duration")

	eCaster:AddNewModifier(eCaster, self, "modifier_item_standef_windlace_active", {duration = fDuration})
	EmitSoundOn("DOTA_Item.PhaseBoots.Activate", eCaster)
end
