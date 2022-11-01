hero_deformed_cultist_psychichemorrhage_modifier = class({})

function hero_deformed_cultist_psychichemorrhage_modifier:IsHidden()
	return false
end

function hero_deformed_cultist_psychichemorrhage_modifier:IsDebuff()
	return true
end

function hero_deformed_cultist_psychichemorrhage_modifier:RemoveOnDeath()
	return true
end

function hero_deformed_cultist_psychichemorrhage_modifier:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function hero_deformed_cultist_psychichemorrhage_modifier:GetStatusEffectName()
	return "particles/status_fx/status_effect_bloodrage.vpcf"
end

function hero_deformed_cultist_psychichemorrhage_modifier:StatusEffectPriority()
	return MODIFIER_PRIORITY_HIGH
end

function hero_deformed_cultist_psychichemorrhage_modifier:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS 
	}
end

function hero_deformed_cultist_psychichemorrhage_modifier:GetModifierMagicalResistanceBonus()
	return -self:GetAbility():GetSpecialValueFor("magic_resistance_reduction_pct")
end

function hero_deformed_cultist_psychichemorrhage_modifier:OnCreated(eventInfo)
	if not IsServer() then return end

	self:BleedTick()

	self:StartIntervalThink(1)
end

function hero_deformed_cultist_psychichemorrhage_modifier:OnIntervalThink()
	if not IsServer() then return end

	self:BleedTick()
end

function hero_deformed_cultist_psychichemorrhage_modifier:BleedTick()
	local eCaster = self:GetCaster()
	local eParent = self:GetParent()
	local hAbility = self:GetAbility()
	local fIntelligenceDamageMultiplier = hAbility:GetSpecialValueFor("bleed_intelligence_damage_pct") / 100
	local fIntelligence = eCaster:GetIntellect()
	local fSpellAmp = eCaster:GetSpellAmplification(false)

	local fDamage = (fIntelligence * fIntelligenceDamageMultiplier) * (1 + fSpellAmp)

	local hOptions = {
		victim = eParent,
		attacker = eCaster,
		damage = fDamage,
		damage_type = hAbility:GetAbilityDamageType(),
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		ability = self
	}
	ApplyDamage(hOptions)

	local sParticleName = "particles/generic_gameplay/generic_hit_blood.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN, eParent)
	ParticleManager:SetParticleControl(iParticleID, 0, eParent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(iParticleID)
	
	EmitSoundOn("Hero_Lion.Attack", eParent)
end