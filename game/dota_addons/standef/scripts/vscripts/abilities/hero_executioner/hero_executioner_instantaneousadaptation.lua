LinkLuaModifier("hero_executioner_instantaneousadaptation_modifier", "modifiers/abilities/hero_executioner/hero_executioner_instantaneousadaptation_modifier", LUA_MODIFIER_MOTION_NONE)

hero_executioner_instantaneousadaptation = class({})

function hero_executioner_instantaneousadaptation:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context)
end

function hero_executioner_instantaneousadaptation:Spawn()
	if not IsServer() then return end
	self:SetLevel(1)
end

function hero_executioner_instantaneousadaptation:ResetToggleOnRespawn()
	return true
end

function hero_executioner_instantaneousadaptation:OnToggle()
	if not IsServer() then return end

	local bToggled = self:GetToggleState()
	local eCaster = self:GetCaster()
	local sParticleName = "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_green.vpcf"

	if bToggled then
		eCaster:AddNewModifier(eCaster, self, "hero_executioner_instantaneousadaptation_modifier", {})
		EmitSoundOn("DOTA_Item.Sheepstick.Activate", eCaster)
		local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN, eCaster)
		ParticleManager:SetParticleControl(iParticleID, 0, eCaster:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(iParticleID)
	else
		eCaster:RemoveModifierByName("hero_executioner_instantaneousadaptation_modifier")
		EmitSoundOn("DOTA_Item.Sheepstick.Activate", eCaster)
		local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ROOTBONE_FOLLOW, eCaster)
		ParticleManager:SetParticleControl(iParticleID, 0, eCaster:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(iParticleID)
	end
end