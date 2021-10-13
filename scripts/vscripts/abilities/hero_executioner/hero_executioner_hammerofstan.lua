hero_executioner_hammerofstan = class({})

function hero_executioner_hammerofstan:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_faceless_void.vsndevts", context)	
	PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context)
end

function hero_executioner_hammerofstan:GetManaCost(iLevel)
	local fManaCostPercent = self:GetSpecialValueFor("mana_pct")
	local fMaxMana = self:GetCaster():GetMaxMana()

	return fMaxMana * (fManaCostPercent / 100)
end

function hero_executioner_hammerofstan:OnAbilityPhaseStart()
	if not IsServer() then return end
	
	EmitSoundOn("Hero_FacelessVoid.TimeDilation.Cast.ti7_layer", eTarget)
	
	return true
end

function hero_executioner_hammerofstan:OnSpellStart()
	if not IsServer() then return end

	local eCaster = self:GetCaster()
	local eTarget = self:GetCursorTarget()

	EmitSoundOn("Hero_FacelessVoid.TimeLockImpact", eTarget)
	EmitSoundOn("Hero_FacelessVoid.TimeLockImpact", eTarget)
	EmitSoundOn("DOTA_Item.MeteorHammer.Impact", eTarget)

	local fBaseDamage = self:GetSpecialValueFor("damage")

	local fStrengthDamageMultiplier = self:GetSpecialValueFor("strength_damage_pct") / 100
	local fStrength = eCaster:GetStrength()
	local fSpellAmp = eCaster:GetSpellAmplification(false)

	local fTotalDamage = (fBaseDamage + (fStrength * fStrengthDamageMultiplier)) * (1 + fSpellAmp)

	local hOptions = {
		victim = eTarget,
		attacker = eCaster,
		damage = fTotalDamage,
		damage_type = self:GetAbilityDamageType(),
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		ability = self
	}
	ApplyDamage(hOptions)

	local sParticleName = "particles/basic_explosion/basic_explosion_burst.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN, eTarget)
	ParticleManager:ReleaseParticleIndex(iParticleID)

	local sParticleName = "particles/econ/events/fall_major_2016/cyclone_fm06_ground_dust.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN, eTarget)
	ParticleManager:ReleaseParticleIndex(iParticleID)


	local fKnockbackDistance = self:GetSpecialValueFor("knockback_distance")
	local vKnockbackDirection = (eTarget:GetAbsOrigin() - eCaster:GetAbsOrigin())
	local vKnockbackVector = vKnockbackDirection * fKnockbackDistance

    local hKnockbackInfo =
    {
        center_x = vKnockbackVector.x,
        center_y = vKnockbackVector.y,
        center_z = vKnockbackVector.z,
        duration = 0.5 * (1 - eTarget:GetStatusResistance()),
        knockback_duration = 0.5,
        knockback_distance = -fKnockbackDistance,
        should_stun = 0,
        knockback_height = 0
    }

    eTarget:AddNewModifier(eCaster, self, "modifier_knockback", hKnockbackInfo)
end