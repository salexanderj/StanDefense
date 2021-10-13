LinkLuaModifier("hero_deformed_cultist_psychichemorrhage_modifier", "modifiers/abilities/hero_deformed_cultist/hero_deformed_cultist_psychichemorrhage_modifier", LUA_MODIFIER_MOTION_NONE)

hero_deformed_cultist_psychichemorrhage = class({})

function hero_deformed_cultist_psychichemorrhage:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_lion.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_bloodseeker.vsndevts", context)
end

function hero_deformed_cultist_psychichemorrhage:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function hero_deformed_cultist_psychichemorrhage:CastFilterResultLocation(vLocation)
	if not IsServer() then return end

	local eCaster = self:GetCaster()
	local iTargetFlags = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local iTeam = self:GetTeamNumber()

	local eTargets = FindUnitsInRadius(iTeam, vLocation, nil, self:GetAOERadius(), DOTA_UNIT_TARGET_TEAM_ENEMY, iTargetFlags, 0, FIND_ANY_ORDER, false)

	if #eTargets < 1 then
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end

function hero_deformed_cultist_psychichemorrhage:GetCustomCastErrorLocation(vLocation)
	return "No targets"
end

function hero_deformed_cultist_psychichemorrhage:OnSpellStart()
	if not IsServer() then return end

	local eCaster = self:GetCaster()
	local vLocation = self:GetCursorPosition()
	local iTeam = eCaster:GetTeamNumber()
	local iTargetFlags = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local iDuration = self:GetSpecialValueFor("duration")

	local eTargets = FindUnitsInRadius(iTeam, vLocation, nil, self:GetAOERadius(), DOTA_UNIT_TARGET_TEAM_ENEMY, iTargetFlags, 0, FIND_ANY_ORDER, false)

	for i, v in ipairs(eTargets) do
		if v then
			--EmitSoundOn("hero_bloodseeker.rupture", v)
			v:EmitSoundParams("hero_bloodseeker.rupture", 1, 0.3, 0)
			v:AddNewModifier(eCaster, self, "hero_deformed_cultist_psychichemorrhage_modifier", {duration = iDuration})
		end
	end

	local sParticleName = "particles/econ/items/lifestealer/ls_ti10_immortal/ls_ti10_immortal_infest_blood_ground_large.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_POINT, eCaster)
	ParticleManager:SetParticleControl(iParticleID, 0, vLocation)
	ParticleManager:ReleaseParticleIndex(iParticleID)
end
