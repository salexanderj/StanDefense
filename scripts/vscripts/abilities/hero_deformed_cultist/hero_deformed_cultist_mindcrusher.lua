LinkLuaModifier("hero_deformed_cultist_mindcrusher_modifier", "modifiers/abilities/hero_deformed_cultist/hero_deformed_cultist_mindcrusher_modifier", LUA_MODIFIER_MOTION_NONE)

hero_deformed_cultist_mindcrusher = class({})

function hero_deformed_cultist_mindcrusher:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_lion.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context)
end

function hero_deformed_cultist_mindcrusher:OnSpellStart()
	if not IsServer() then return end

	local eCaster = self:GetCaster()
	local eTarget = self:GetCursorTarget()

	local fDuration = self:GetSpecialValueFor("duration")

	EmitSoundOn("Hero_Lion.FoD.Cast.TI8_layer", eCaster)
	EmitSoundOn("DOTA_Item.Nullifier.Target", eTarget)

	eTarget:AddNewModifier(eCaster, self, "hero_deformed_cultist_mindcrusher_modifier", {duration = fDuration})

	local sParticleName = "particles/units/heroes/hero_lion/lion_spell_finger_of_death.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_POINT, eCaster)
	ParticleManager:SetParticleControl(iParticleID, 0, eCaster:GetAbsOrigin())
	ParticleManager:SetParticleControl(iParticleID, 1, eTarget:GetAbsOrigin())
	ParticleManager:SetParticleControl(iParticleID, 2, Vector(0, 0, 0))
	ParticleManager:SetParticleControl(iParticleID, 60, Vector(255, 255, 255))
	ParticleManager:SetParticleControl(iParticleID, 61, Vector(1, 0, 0))
	ParticleManager:ReleaseParticleIndex(iParticleID)
end