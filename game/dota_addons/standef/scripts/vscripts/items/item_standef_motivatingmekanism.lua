LinkLuaModifier("modifier_item_standef_motivatingmekanism", "modifiers/items/modifier_item_standef_motivatingmekanism", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_standef_motivatingmekanism_active", "modifiers/items/modifier_item_standef_motivatingmekanism_active", LUA_MODIFIER_MOTION_NONE)

item_standef_motivatingmekanism = class({})

function item_standef_motivatingmekanism:GetIntrinsicModifierName()
	return "modifier_item_standef_motivatingmekanism"
end

function item_standef_motivatingmekanism:OnSpellStart()
	local eCaster = self:GetCaster()
	local sParticleName = "particles/econ/events/ti9/mekanism_ti9.vpcf"

	local iRadius = self:GetSpecialValueFor("active_radius")
	local iTargetFlags = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local eTargets = FindUnitsInRadius(eCaster:GetTeamNumber(), eCaster:GetAbsOrigin(), nil, iRadius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, iTargetFlags, 0, FIND_ANY_ORDER, false)

	EmitSoundOn("DOTA_Item.Mekansm.Activate", eCaster)

	local fDuration = self:GetSpecialValueFor("active_duration")
	for i, v in ipairs(eTargets) do
		EmitSoundOn("DOTA_Item.Mekansm.Target", v)
		v:AddNewModifier(eCaster, self, "modifier_item_standef_motivatingmekanism_active", {duration = fDuration})
		local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN_FOLLOW, v)
		ParticleManager:ReleaseParticleIndex(iParticleID)
	end
end