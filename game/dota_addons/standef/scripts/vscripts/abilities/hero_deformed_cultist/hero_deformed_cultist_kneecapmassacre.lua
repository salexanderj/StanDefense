LinkLuaModifier("hero_deformed_cultist_kneecapmassacre_modifier", "modifiers/abilities/hero_deformed_cultist/hero_deformed_cultist_kneecapmassacre_modifier", LUA_MODIFIER_MOTION_NONE)

hero_deformed_cultist_kneecapmassacre = class({})

function hero_deformed_cultist_kneecapmassacre:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_phantom_assassin.vsndevts", context)
end

function hero_deformed_cultist_kneecapmassacre:GetCastRange(vLocation, eTarget)
	return self:GetSpecialValueFor("radius")
end

function hero_deformed_cultist_kneecapmassacre:OnSpellStart()
	if not IsServer() then return end

	local eCaster = self:GetCaster()

	local fBaseDamage = self:GetSpecialValueFor("damage")
	local fSpellAmp = eCaster:GetSpellAmplification(false)
	local fDamage = fBaseDamage * (1 + fSpellAmp)

	local fBaseDuration = self:GetSpecialValueFor("base_duration")
	local fIntelligenceDurationMutliplier = self:GetSpecialValueFor("intelligence_duration_pct") / 100
	local fIntelligence = eCaster:GetIntellect()

	local fDuration = fBaseDuration + (fIntelligence * fIntelligenceDurationMutliplier)

	local iTeam = eCaster:GetTeamNumber()
	local iTargetFlags = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC

	local eTargets = FindUnitsInRadius(iTeam, eCaster:GetAbsOrigin(), nil, self:GetCastRange(nil, nil), DOTA_UNIT_TARGET_TEAM_ENEMY, iTargetFlags, 0, FIND_ANY_ORDER, false)

	EmitSoundOn("Hero_Lion.FoD.Cast.TI8_layer", eCaster)

	local sParticleName = "particles/econ/events/fall_major_2016/cyclone_fm06_ground_dust.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_POINT, eCaster)
	ParticleManager:SetParticleControl(iParticleID, 0, eCaster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(iParticleID)

	local sParticleName = "particles/econ/items/oracle/oracle_ti10_immortal/oracle_ti10_immortal_purifyingflames_dust_hit_shock_b.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_POINT, eCaster)
	ParticleManager:SetParticleControl(iParticleID, 0, eCaster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(iParticleID)

	for i, v in ipairs(eTargets) do
		v:AddNewModifier(eCaster, self, "hero_deformed_cultist_kneecapmassacre_modifier", {duration = fDuration})
		v:EmitSoundParams("Hero_PhantomAssassin.CoupDeGrace", 1, 1.25, 0)
		v:EmitSoundParams("Hero_Lion.FoD.Target.TI8_layer", 1, 0.75, 0)

		local sParticleName = "particles/units/heroes/hero_lion/lion_spell_finger_of_death.vpcf"
		local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_POINT, eCaster)
		ParticleManager:SetParticleControl(iParticleID, 0, eCaster:GetAbsOrigin())
		ParticleManager:SetParticleControl(iParticleID, 1, v:GetAbsOrigin())
		ParticleManager:SetParticleControl(iParticleID, 2, Vector(0, 0, 0))
		ParticleManager:SetParticleControl(iParticleID, 60, Vector(255, 0, 0))
		ParticleManager:SetParticleControl(iParticleID, 61, Vector(1, 0, 0))
		ParticleManager:ReleaseParticleIndex(iParticleID)

		sParticleName = "particles/econ/items/sniper/sniper_charlie/sniper_assassinate_impact_blood_charlie.vpcf"
		local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_POINT, eCaster)
		ParticleManager:SetParticleControl(iParticleID, 0, eCaster:GetAbsOrigin())
		ParticleManager:SetParticleControl(iParticleID, 1, v:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(iParticleID)
		
		sParticleName = "particles/econ/items/sniper/sniper_charlie/sniper_assassinate_impact_blood_charlie.vpcf"
		local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_POINT, eCaster)
		ParticleManager:SetParticleControl(iParticleID, 0, eCaster:GetAbsOrigin())
		ParticleManager:SetParticleControl(iParticleID, 1, v:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(iParticleID)

		local hOptions = {
			victim = v,
			attacker = eCaster,
			damage = fDamage,
			damage_type = self:GetAbilityDamageType(),
			damage_flags = DOTA_DAMAGE_FLAG_NONE,
			ability = self
		}
		ApplyDamage(hOptions)
	end
end