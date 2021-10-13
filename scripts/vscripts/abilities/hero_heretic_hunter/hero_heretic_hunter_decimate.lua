LinkLuaModifier("hero_heretic_hunter_decimate_modifier", "modifiers/abilities/hero_heretic_hunter/hero_heretic_hunter_decimate_modifier", LUA_MODIFIER_MOTION_NONE)

hero_heretic_hunter_decimate = class({})

function hero_heretic_hunter_decimate:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_templar_assassin.vsndevts", context)
end

function hero_heretic_hunter_decimate:OnSpellStart()

	local eCaster = self:GetCaster()
	local vCasterPosition = eCaster:GetAbsOrigin()
	local iTeam = self:GetTeamNumber()
	local iRadius = self:GetCastRange(vCasterPosition, eCaster)
	local iTargetFlags = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local sParticleName = "particles/econ/items/outworld_devourer/od_ti8/od_ti8_santies_eclipse_area_shockwave.vpcf"

	local eTargets = FindUnitsInRadius(iTeam, vCasterPosition, nil, iRadius, DOTA_UNIT_TARGET_TEAM_ENEMY, iTargetFlags, 0, FIND_ANY_ORDER, false)

	EmitSoundOn("Roshan.Slam", eCaster)

	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN, eCaster)
	ParticleManager:SetParticleControl(iParticleID, 0, vCasterPosition)
	ParticleManager:ReleaseParticleIndex(iParticleID)

	for i, v in ipairs(eTargets) do
		local sParticleName = "particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp_dust_sand.vpcf"
		local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN_FOLLOW, v)
		ParticleManager:SetParticleControlEnt(iParticleID, 0, v, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", v:GetAbsOrigin(), false)
		ParticleManager:SetParticleControl(iParticleID, 1, Vector(1, 1, 1))
		ParticleManager:ReleaseParticleIndex(iParticleID)
		v:AddNewModifier(eCaster, self, "hero_heretic_hunter_decimate_modifier", {})
	end
end