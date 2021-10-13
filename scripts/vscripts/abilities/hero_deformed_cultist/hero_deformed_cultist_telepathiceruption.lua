require("libraries/timers")

hero_deformed_cultist_telepathiceruption = class({})

function hero_deformed_cultist_telepathiceruption:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_leshrac.vsndevts", context)
end

function hero_deformed_cultist_telepathiceruption:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function hero_deformed_cultist_telepathiceruption:OnSpellStart()
	if not IsServer() then return end

	local eCaster = self:GetCaster()
	local vLocation = self:GetCursorPosition()
	local iTeam = eCaster:GetTeamNumber()
	local iTargetFlags = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local iStunDuration = self:GetSpecialValueFor("stun_duration")

	local fBaseDamage = self:GetSpecialValueFor("damage")
	local fIntelligenceDamageMultiplier = self:GetSpecialValueFor("intelligence_damage_pct") / 100
	local fIntelligence = eCaster:GetIntellect()
	local fSpellAmp = eCaster:GetSpellAmplification(false)

	local fDamage = fBaseDamage + (fIntelligence * fIntelligenceDamageMultiplier) * (1 + fSpellAmp)

	local eTargets = FindUnitsInRadius(iTeam, vLocation, nil, self:GetAOERadius(), DOTA_UNIT_TARGET_TEAM_ENEMY, iTargetFlags, 0, FIND_ANY_ORDER, false)

	for i, v in ipairs(eTargets) do

		v:AddNewModifier(eCaster, self, "modifier_stunned", {duration=iStunDuration})

		vPosition = v:GetAbsOrigin()
	    local hKnockbackInfo = {
	        center_x = vPosition.x,
	        center_y = vPosition.y,
	        center_z = vPosition.z,
	        duration = 0.5,
	        knockback_duration = 0.5,
	        knockback_distance = 0,
	        should_stun = 0,
	        knockback_height = 100
	    }
	    v:AddNewModifier(eCaster, self, "modifier_knockback", hKnockbackInfo)
		
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

	EmitSoundOnLocationWithCaster(vLocation, "Hero_Leshrac.Split_Earth.Tormented", eCaster)

	local sParticleName = "particles/econ/items/earthshaker/egteam_set/hero_earthshaker_egset/earthshaker_fissure_small_rocks_egset.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_POINT, eCaster)
	ParticleManager:SetParticleControl(iParticleID, 0, vLocation)
	ParticleManager:SetParticleControl(iParticleID, 1, vLocation)

	Timers:CreateTimer({
		endTime = 1,
		callback = function()
			ParticleManager:DestroyParticle(iParticleID, false)
			ParticleManager:ReleaseParticleIndex(iParticleID)
		end
	})

	local sParticleName = "particles/econ/items/ursa/ursa_ti10/ursa_ti10_earthshock_rocks_kickup.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_POINT, eCaster)
	ParticleManager:SetParticleControl(iParticleID, 0, vLocation)
	ParticleManager:ReleaseParticleIndex(iParticleID)

	local sParticleName = "particles/econ/events/fall_major_2016/force_staff_fm06_dust.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_POINT, eCaster)
	ParticleManager:SetParticleControl(iParticleID, 0, vLocation)
	ParticleManager:ReleaseParticleIndex(iParticleID)	
end